import 'dart:io';
import 'package:dl_helper/windows_install.dart';
import 'package:path_provider/path_provider.dart';

import 'package:background_downloader/background_downloader.dart';

Future<String> download(
  String audioFile,
  String videoFile,
  String outputName,
) async {
  if (Platform.isWindows) {
    await setupFFMpegOnWindows();
  }

  // download the batch
  final Directory tempDir = await getTemporaryDirectory();
  final Directory folder = await tempDir.createTemp('dl_helper');
  try {
    final audioUri = Uri.parse(audioFile);
    final videoUri = Uri.parse(videoFile);
    final audioTask = DownloadTask(
      url: "${audioUri.origin}${audioUri.path}",
      directory: folder.path,
      filename: 'audio.mp4',
    );
    final videoTask = DownloadTask(
      url: "${videoUri.origin}${videoUri.path}",
      directory: folder.path,
      filename: 'video.mp4',
    );
    final outputTask = DownloadTask(
      url: audioFile,
      directory: folder.path,
      filename: outputName,
    );
    final tasks = [
      audioTask,
      videoTask,
    ];

    await FileDownloader().downloadBatch(
      tasks,
      batchProgressCallback: (succeeded, failed) => print(
          'Completed ${succeeded + failed} out of ${tasks.length}, $failed failed'),
    );

    var returnCode = await runFFmpegCommand(
      '-i ${await audioTask.filePath()} -i ${await videoTask.filePath()} -map 0:a -map 1:v -c:v copy -shortest ${await outputTask.filePath()}',
    );
    if (returnCode.isValueError()) {
      throw Exception('Failed to run ffmpeg');
    }
    if (returnCode.isValueCancel()) {
      throw Exception('ffmpeg task cancelled');
    }
    var res = await FileDownloader()
        .moveToSharedStorage(outputTask, SharedStorage.downloads);
    return 'Video downloaded: ${res ?? ''}';
  } catch (err) {
    return 'Error: ${err.toString()}';
  }
}
