import 'package:coacheers/coaching/camera/camera.dart';
import 'package:coacheers/coaching/camera/camerademo.dart';
import 'package:coacheers/frame/mainFrame.dart';
import 'package:flutter/material.dart';

class CoachingPage extends StatefulWidget {
  const CoachingPage({Key? key}) : super(key: key);

  @override
  State<CoachingPage> createState() => _CoachingPageState();
}

class _CoachingPageState extends State<CoachingPage> {
  @override
  bool shouldPop = false;


  Widget build(BuildContext context) {
    print("메인 페이지 - 코칭 페이지\n");
    // debugShowCheckedModeBanner: false,
    return CamerademoPage();
    //return CameraPage();
    //return Scaffold();
  }
}

