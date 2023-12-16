import 'dart:io';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

import 'package:background_downloader/background_downloader.dart';

Future<String> download(
  String audioFile,
  String videoFile,
  String outputName,
) async {
  // download the batch
  final Directory tempDir = await getTemporaryDirectory();
  final Directory folder = await tempDir.createTemp('dl_helper');
  final audioUri = Uri.parse(audioFile);
  final videoUri = Uri.parse(videoFile);
  print("${audioUri.origin}${audioUri.path}");
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

  print("======");
  print(await outputTask.filePath());
  print(await audioTask.filePath());
  print(await videoTask.filePath());
  print("======");

  await FFmpegKit.execute(
    '-i ${await audioTask.filePath()} -i ${await videoTask.filePath()} -map 0:a -map 1:v -c:v copy -shortest ${await outputTask.filePath()}',
  ).then((session) async {
    final returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      print("WE DID IT");
    } else if (ReturnCode.isCancel(returnCode)) {
      print("CANCEL");
    } else {
      print("ERROR");
    }
  });
  var res = await FileDownloader()
      .moveToSharedStorage(outputTask, SharedStorage.downloads);
  return res ?? '';
}
