import 'package:coacheers/coaching/camera/camerademo.dart';
import 'package:coacheers/coaching/camera/coachingPage.dart';
import 'package:coacheers/home/homePage.dart';
import 'package:coacheers/profile/profilePage.dart';
import 'package:coacheers/record/recordPage.dart';
import 'package:flutter/material.dart';


class MainFrame extends StatefulWidget {
  final int id;
  final String name;
  final String profileURL;
  late int subindex;

  MainFrame({Key? key, required this.id, required this.name, required this.profileURL, required this.subindex}) : super(key: key);

  @override
  State<MainFrame> createState() => _MainFrameWidget();
}

class _MainFrameWidget extends State<MainFrame> {
// 탭을 이동할 때 쓸 변수!

  @override
  bool shouldPop = false;
  int _selectedIndex = 2;
  double memberCode = 2489925368;

  List<Widget> _widgetOptions() => [
    RecordPage(id : widget.id, nickname : widget.name, profileURL : widget.profileURL),
    //CoachingPage(),
    ProfilePage(id : widget.id, nickname : widget.name, profileURL : widget.profileURL),
    Home(id: widget.id,),
  ];

  @override
  Widget build(BuildContext context) {
    print("메인 페이지\n");
    //print(widget.name);
    //print(widget.profileURL);
    //get();
    _onItemTapped(widget.subindex);
    final List<Widget> widgetOptions = _widgetOptions();
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
          child: widgetOptions[_selectedIndex],
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

  // void _get_user_info() async {
  //   try {
  //     User user = await UserApi.instance.me();
  //     print('사용자 정보 요청 성공'
  //         '\n회원번호: ${user.id}'
  //         '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
  //         '\n프로필사진링크 : ${user.kakaoAccount?.profile?.thumbnailImageUrl}');
  //     profileURL = (user.kakaoAccount?.profile?.thumbnailImageUrl).toString();
  //   } catch (error) {
  //     print('사용자 정보 요청 실패 $error');
  //   }
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      widget.subindex = _selectedIndex;
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

  // void get() async {
  //   String url = "http://localhost:8000/users";
  //   var response = await http.get(Uri.parse(url));
  //   var statusCode = response.statusCode;
  //   var responseHeaders = response.headers;
  //   var responseBody = utf8.decode(response.bodyBytes);
  //
  //   Map<String, dynamic> user = jsonDecode(responseBody);
  //
  //   print(user);
  //
  //   print("statusCode: ${statusCode}");
  //   print("responseHeader: ${responseHeaders}");
  //   print("responseBody: ${responseBody}");
  // }
}
