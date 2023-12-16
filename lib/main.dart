import 'package:dl_helper/download.dart';
import 'package:dl_helper/help_dialog.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vimeo Downloader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Vimeo Downloader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;
  final audioController = TextEditingController();
  final videoController = TextEditingController();
  final outputController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    audioController.dispose();
    videoController.dispose();
    outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          TextButton.icon(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return const Dialog(
                      child: HelpDialog(),
                    );
                  });
            },
            icon: const Icon(Icons.question_mark),
            label: const Text("Help"),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Files will be saved to your downloads directory.",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (v) {
                          setState(() {});
                        },
                        controller: audioController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Audio URL',
                          hintText: 'Enter the audio url here',
                          helperText: 'The parcel/audio url you found',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (v) {
                          setState(() {});
                        },
                        controller: videoController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Video URL',
                          hintText: 'Enter the video url here',
                          helperText: 'The parcel/video url you found',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (v) {
                          setState(() {});
                        },
                        controller: outputController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'File Name',
                          hintText: 'my-recording.mp4',
                          helperText:
                              'What the output file should be called (end with .mp4)',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: (audioController.value.text.isNotEmpty &&
              videoController.value.text.isNotEmpty &&
              outputController.value.text.isNotEmpty)
          ? FloatingActionButton(
              onPressed: loading
                  ? null
                  : () async {
                      setState(() {
                        loading = true;
                      });
                      String filename = await download(
                        audioController.value.text,
                        videoController.value.text,
                        outputController.value.text,
                      );
                      setState(() {
                        loading = false;
                      });
                      var snackBar = SnackBar(
                        duration: const Duration(
                          seconds: 5,
                        ),
                        content: SelectableText("Video downloaded: $filename"),
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
              tooltip: 'Download',
              child: loading
                  ? Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(2.0),
                      child: const CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 3,
                      ),
                    )
                  : const Icon(Icons.download),
            )
          : null,
    );
  }
}
