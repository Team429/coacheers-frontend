import 'package:coacheers/coaching/coachingEndPage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CamerademoPage extends StatefulWidget {
  final int id;
  final String name;
  final String profileURL;

  const CamerademoPage(
      {Key? key,
      required this.id,
      required this.name,
      required this.profileURL})
      : super(key: key);

  @override
  _CamerademoPageState createState() => _CamerademoPageState();
}

class _CamerademoPageState extends State<CamerademoPage> {
  bool _isRecording = false;
  bool shouldPop = false;

  late VideoPlayerController controller;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    controller.dispose();

    super.dispose();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.asset('/assets/videos/Test.mp4');
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(alignment: Alignment.center, children: [
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 600, 0, 0),
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(controller.value.isPlaying ? Icons.stop : Icons.circle),
            onPressed: () {
              if (controller.value.isPlaying) {
                controller.pause();
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CoachingEnd(
                            id: widget.id,
                            name: widget.name,
                            profileURL: widget.profileURL,
                            filePath: '/assets/videos/Test.mp4')),
                  );
                });
              } else {
                controller.play();
              }
              setState(() {});
            },
          ),
        ),
      ]),
    );
  }
}
