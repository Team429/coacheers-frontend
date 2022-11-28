import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:coacheers/coaching/camera/camerademo.dart';
import 'package:coacheers/coaching/coachingSavePage.dart';
import 'package:coacheers/frame/mainFrame.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class CoachingEnd extends StatefulWidget {
  final int id;
  final String name;
  final String profileURL;
  final String filePath;

  const CoachingEnd({Key? key, required this.id, required this.name, required this.profileURL, required this.filePath}) : super(key: key);

  @override
  State<CoachingEnd> createState() => _CoachingEndState();
}

class _CoachingEndState extends State<CoachingEnd> {
  late VideoPlayerController _videoPlayerController;
  late TextEditingController _commentController;

  @override
  Widget build(BuildContext context) {
    bool shouldPop = false;

    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Coacheers",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
                size: 24,
              ),
              onPressed: () {
                alertDialog(context, 2);
              },
            ),
          ],
          backgroundColor: Color(0xfffffffff),
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            children: [
              underline(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Column(
                    children: [
                      text( "모의 면접이 종료 되었습니다!"),
                      text( "수고하셨습니다!"),
                      image(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
                        child: Row(
                          children: [
                            Image(
                                image: AssetImage('assets/new.png'), width: 24),
                            Container(
                              child: Text(
                                " 메모 ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      textfield(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
                        child: Row(
                          children: [
                            Image(
                                image: AssetImage('assets/time.png'),
                                width: 24),
                            Container(
                              child: Text(
                                " 날짜 ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      gettime(),
                      saveButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
            color: Color(0xff1877F2),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: FloatingActionButton(
                          heroTag: "record",
                          onPressed: () {
                            alertDialog(context,0);
                          },
                          child: Icon(
                            Icons.history,
                            size: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "기록",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                  child: FloatingActionButton.extended(
                    elevation: 4.0,
                    icon: const Icon(
                      Icons.wifi_tethering,
                    ),
                    heroTag: "coaching start",
                    label: Text("모의 면접 코칭 시작"),
                    onPressed: () {
                      recordalertDialog(context);
                      //_onItemTapped(1);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: FloatingActionButton(
                          heroTag: "my",
                          onPressed: () {
                            alertDialog(context,1);
                          },
                          child: Icon(
                            Icons.person,
                            size: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "마이",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget underline(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Container(
        height: 1.0,
        width: 300.0,
        color: Colors.grey,
      ),
    );
  }

  Widget text(String comment){
    return Text(
     comment,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget image(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Image(
          image: AssetImage('assets/Coacheers.png'),
          width: 250),
    );
  }

  Widget textfield(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
      child: TextField(
        // obscureText: true,
        controller: _commentController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: '메모할 내용을 적어주세요.',
        ),
      ),
    );
  }

  Widget gettime(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 80, 0),
      child: Text(
        getToday(),
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget saveButton(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: FloatingActionButton.extended(
        backgroundColor: Color(0xff1ABC9C),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        icon: const Icon(
          Icons.save,
        ),
        heroTag: "Save",
        label: Text("저장하기"),
        onPressed: () {
          print(widget.filePath);
          print(_commentController.text);
          print(DateTime.now().toString());
          _post_record_info(widget.id,_commentController.text,widget.filePath);
          uploadFileToServer(File(widget.filePath),widget.filePath,DateTime.now());
          //userData.add(UserData(_commentController.text.toString(),DateTime.now(),widget.filePath,0,0,0));
          //print(userData[0].companyName);
          //print(userData.length);
          Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder:
                    (_) => //VideoPage(filePath: file.path),
                //VideoPage(filePath: widget.filePath, name: _commentController.text),
                coachingSave(id : widget.id, comment : _commentController.text, name: widget.name, profileURL: widget.profileURL, filePath: widget.filePath)
              ));
          //CoachingButtonDialog(context);
        },
      ),
    );
  }

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy년 MM월 dd일 kk : mm');
    var strToday = formatter.format(now);
    return strToday;
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();

  }

  alertDialog(context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title

            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  "홈으로 돌아가게 될시 면접이 저장이 되지 않을 수도 있습니다. 그래도 돌아가시겠습니까?",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainFrame(id : widget.id, name : widget.name, profileURL: widget.profileURL, subindex: index,)),
                  );
                },
              ),
              new TextButton(
                child: new Text("취소"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  recordalertDialog(context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title

            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  "홈으로 돌아가게 될시 면접이 저장이 되지 않을 수도 있습니다. 그래도 돌아가시겠습니까?",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                  CoachingButtonDialog(context);
                },
              ),
              new TextButton(
                child: new Text("취소"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  CoachingButtonDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("코칭 영상 선택"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new TextButton(
                  child: new Text("앨범에서 영상 선택"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                new TextButton(
                  child: new Text("영상 녹화 시작"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CamerademoPage(id : widget.id, name: widget.name,profileURL: widget.profileURL,)),
                    );
                  },
                ),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("취소"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void _post_record_info(int id, String companyName,String filepath) async {
    String url = 'http://localhost:8000/records/';
    DateTime Date = DateTime.now();
    var jsonEncode2 = jsonEncode({
      "user_id": id,
      "created_at": Date.add(Duration(hours : 9)).millisecondsSinceEpoch,
      "label": companyName,
      "filepath": filepath,
      "anger_score": 0,
      "joy_score": 0,
      "sorrow_score": 0,
      "surprised_score": 0,
      "voice_score": 0
    });
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{"content-type": "application/json"},
        body: jsonEncode2);
    var decode = utf8.decode(response.bodyBytes);
    //print("Response : ${response.statusCode} ${decode}");
    //print(response.headers);

    //print(filepath);

  }

  void uploadFileToServer(File videopath, String filepath, DateTime date) async {
    String url = 'http://localhost:8000/videos/';
    var request = new http.MultipartRequest(
        "POST", Uri.parse(url));

    print(request);

    request.fields['filepath'] = filepath;
    request.fields['create_at'] = date.add(Duration(hours : 9)).millisecondsSinceEpoch.toString();
    //request.fields['title'] = 'My first image';
    request.files.add(
        await http.MultipartFile.fromPath('video', videopath.path));
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          print(response);
          // get your response here...
        } catch (e) {
          // handle exeption
        }
      });
    });
  }
}


