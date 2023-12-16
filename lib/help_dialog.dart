import 'package:flutter/material.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guide"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step 1: Go to video to download (Chrome)",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/step1.png'),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step 2: Open Developer Tools (Ctrl + Shift + I) or (Right click > Inspect)",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "Follow the image to make sure you have the correct tab open (Network) along with the searching for 'parcel'",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/step2.png'),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step 3: Refresh (Ctrl + R) the page with the devtools still open",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step 4: Play and Pause the video for a second",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "At this point you'll start to see some network requests in the devtool panel you opened previously.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step 5: Click on a row",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "Follow the image to make sure you have the correct tab open (Network) along with the searching for 'parcel'",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "We're now looking for two types of urls. One will have 'parcel/audio' and the other should have 'parcel/video' see examples below. There will be multiple of each depending on how long you've played the video for. We only need one of each.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/network-details.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/audio-url.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/video-url.png'),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step 6: Copy the values into the form",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/form.png'),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step 7: Press the download button and wait",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "This is now downloading the two files and merging them into a single video file. This can take some time.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "Eventually you'll get a conformation that the download has completed.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/downloads.png'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
