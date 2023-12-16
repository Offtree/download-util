import 'dart:convert';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:path/path.dart' as path;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

final String _ffmpegUrl =
    "https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip";

String? _tempFolderPath, _ffmpegInstallationPath, _ffmpegBinDirectory;

Future<void> initialize() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appName = packageInfo.appName;
  Directory tempDir = await getTemporaryDirectory();
  _tempFolderPath = path.join(tempDir.path, "ffmpeg");
  Directory appDocDir = await getApplicationDocumentsDirectory();
  _ffmpegInstallationPath = path.join(appDocDir.path, appName, "ffmpeg");
  _ffmpegBinDirectory = path.join(
      _ffmpegInstallationPath!, "ffmpeg-master-latest-win64-gpl", "bin");
}

Future<ReturnCode> runFFmpegCommand(String cmd) async {
  if (Platform.isWindows) {
    String ffmpeg = 'ffmpeg';
    if ((_ffmpegBinDirectory != null) && (Platform.isWindows)) {
      ffmpeg = path.join(_ffmpegBinDirectory!, "ffmpeg.exe");
    }
    ProcessResult process = await Process.run(
      ffmpeg,
      cmd.split(' '),
    );
    print(process.stderr);
    print(process.stdout);
    var returnCode = ReturnCode(process.exitCode);
    return returnCode;
  } else {
    var res = await FFmpegKit.execute(cmd).then((session) async {
      return await session.getReturnCode();
    });
    return res as ReturnCode;
  }
}

Future<bool> setupFFMpegOnWindows() async {
  if (_tempFolderPath == null ||
      _ffmpegInstallationPath == null ||
      _ffmpegBinDirectory == null) {
    await initialize();
  }

  // Directory setup
  Directory tempDir = Directory(_tempFolderPath!);
  if (await tempDir.exists() == false) {
    await tempDir.create(recursive: true);
  }
  Directory installationDir = Directory(_ffmpegInstallationPath!);
  if (await installationDir.exists() == false) {
    await installationDir.create(recursive: true);
  }

  final String ffmpegZipPath = path.join(_tempFolderPath!, "ffmpeg.zip");
  final File tempZipFile = File(ffmpegZipPath);
  if (await tempZipFile.exists() == false) {
    final downloadTask = DownloadTask(
      url: _ffmpegUrl,
      directory: _tempFolderPath!,
      filename: "ffmpeg.zip",
      taskId: 'download-token',
    );
    await FileDownloader().download(downloadTask);
    await extractFileToDisk(
      await downloadTask.filePath(),
      _ffmpegInstallationPath!,
    );
  }
  return true;
}
