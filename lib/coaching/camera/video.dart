import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  final String name;

  const VideoPage({Key? key, required this.filePath, required this.name}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
                  // VideoPlayer의 종횡비를 제한하세요.
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    // 영상을 보여주기 위해 VideoPlayer 위젯을 사용합니다.
                    child: SizedBox(
                        width: _controller.value.size?.width ?? 0,
                        height: _controller.value.size?.height ?? 0,
                        child: VideoPlayer(_controller)),
                  );
                } else {
                  // 만약 VideoPlayerController가 여전히 초기화 중이라면,
                  // 로딩 스피너를 보여줍니다.
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: false,
                  colors: VideoProgressColors(
                      backgroundColor: Colors.blueGrey,
                      bufferedColor: Colors.blueGrey,
                      playedColor: Colors.blueAccent),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    fixedSize: MaterialStateProperty.all(Size(30, 30)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)))),
                onPressed: () {
                  _controller.pause();
                },
                child: Icon(Icons.pause)),
            Padding(padding: EdgeInsets.fromLTRB(0, 2, 30, 0)),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                    fixedSize: MaterialStateProperty.all<Size>(Size(40, 40)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)))),
                onPressed: () {
                  _controller.play();
                },
                child: Icon(Icons.play_arrow)),
            Padding(padding: EdgeInsets.fromLTRB(30, 2, 0, 0)),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    fixedSize: MaterialStateProperty.all(Size(30, 30)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)))),
                onPressed: () {
                  _controller.seekTo(Duration(
                      seconds: _controller.value.position.inSeconds + 10));
                },
                child: Icon(Icons.fast_forward))
          ],
        )
      ],
    );
      //Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.name),
      //   elevation: 0,
      //   backgroundColor: Colors.black26,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.check),
      //       onPressed: () {
      //         print('do something with the file');
      //       },
      //     )
      //   ],
      // ),
      // extendBodyBehindAppBar: true,
      // body: VideoScreen(),
    //);
  }
  @override
  // Widget VideoScreen(){
  //   return FutureBuilder(
  //     future: _initializeVideoPlayerFuture,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
  //         // VideoPlayer의 종횡비를 제한하세요.
  //         return AspectRatio(
  //           aspectRatio: _controller.value.aspectRatio,
  //           // 영상을 보여주기 위해 VideoPlayer 위젯을 사용합니다.
  //           child: VideoPlayer(_controller),
  //         );
  //       } else {
  //         // 만약 VideoPlayerController가 여전히 초기화 중이라면,
  //         // 로딩 스피너를 보여줍니다.
  //         return Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }

  @override
  Widget VideoPlayButton(){
    return  FloatingActionButton(
      onPressed: () {
        // 재생/일시 중지 기능을 `setState` 호출로 감쌉니다. 이렇게 함으로써 올바른 아이콘이
        // 보여집니다.
        setState(() {
          // 영상이 재생 중이라면, 일시 중지 시킵니다.
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            // 만약 영상이 일시 중지 상태였다면, 재생합니다.
            _controller.play();
          }
        });
      },
      // 플레이어의 상태에 따라 올바른 아이콘을 보여줍니다.
      child: Icon(
        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      ),
    );
  }

  @override
  void initState() {
    //_controller = VideoPlayerController.file(File(widget.filePath));
    _controller = VideoPlayerController.asset(widget.filePath);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
