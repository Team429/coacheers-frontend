import 'package:camera/camera.dart';
import 'package:coacheers/coaching/camera/video.dart';
import 'package:coacheers/coaching/coachingEndPage.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class CamerademoPage extends StatefulWidget {
  const CamerademoPage({Key? key}) : super(key: key);

  @override
  _CamerademoPageState createState() => _CamerademoPageState();
}

class _CamerademoPageState extends State<CamerademoPage> {
  bool _isRecording = false;
  bool shouldPop = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
        child : Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                      width: 5,
                    )),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(_isRecording ? Icons.stop : Icons.circle),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CoachingEnd(filePath: "www")),
                    )
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}
