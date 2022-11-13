import 'package:coacheers/coaching/camera/camera.dart';
import 'package:coacheers/coaching/camera/camerademo.dart';
import 'package:coacheers/coaching/coachingPage.dart';
import 'package:coacheers/home/homePage.dart';
import 'package:coacheers/profile/profilePage.dart';
import 'package:coacheers/record/recordPage.dart';
import 'package:flutter/material.dart';


class MainFrame extends StatefulWidget {
  const MainFrame({Key? key}) : super(key: key);

  @override
  State<MainFrame> createState() => _MainFrameWidget();
}

class _MainFrameWidget extends State<MainFrame> {
// 탭을 이동할 때 쓸 변수!

  @override
  bool shouldPop = false;
  int _selectedIndex = 2;

  static const List<Widget> _widgetOptions = <Widget>[
    RecordPage(),
    //CoachingPage(),
    ProfilePage(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    print("메인 페이지\n");
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
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
                _onItemTapped(2);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Home()),
                //);
              },
            ),
          ],
          backgroundColor: Color(0xfffffffff),
          elevation: 0.0,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
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
                            _onItemTapped(0);
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
                            _onItemTapped(1);
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
                      MaterialPageRoute(
                          builder: (context) => CamerademoPage()),
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
