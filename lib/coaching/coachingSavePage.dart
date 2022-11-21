import 'package:coacheers/coaching/camera/camerademo.dart';
import 'package:coacheers/frame/mainFrame.dart';
import 'package:flutter/material.dart';

class coachingSave extends StatefulWidget {
  final String name;
  final String profileURL;
  final String filePath;

  const coachingSave({Key? key, required this.name, required this.profileURL, required this.filePath}) : super(key: key);

  @override
  State<coachingSave> createState() => _coachingSaveState();
}

class _coachingSaveState extends State<coachingSave> {

  Widget build(BuildContext context) {
    bool shouldPop = false;

    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      MainFrame(
                        name: widget.name,
                        profileURL: widget.profileURL,
                        subindex: 2,)),
                );
              },
            ),
          ],
          backgroundColor: Color(0xfffffffff),
          elevation: 0.0,
        ),
        body: text("저장을 완료 하였습니다!"),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  MainFrame(
                                    name: widget.name,
                                    profileURL: widget.profileURL,
                                    subindex: 0,)),
                            );
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
                      CoachingButtonDialog(context);
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  MainFrame(
                                    name: widget.name,
                                    profileURL: widget.profileURL,
                                    subindex: 1,)),
                            );
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

  Widget text(String comment){
    return Center(
      child: Text(
        comment,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
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
                      MaterialPageRoute(builder: (context) =>
                          CamerademoPage(
                            name: widget.name, profileURL: widget.profileURL,)),
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

}