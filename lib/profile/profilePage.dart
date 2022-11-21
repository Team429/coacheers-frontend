import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class ProfilePage extends StatefulWidget {
  final String nickname;
  final String profileURL;

  const ProfilePage(
      {Key? key, required this.nickname, required this.profileURL})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    print("메인 페이지 - 프로필 페이지\n");
    //_get_user_info();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff1877F2),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(50),
                      )),
                  child: Column(children: [
                    SizedBox(
                      height: 23.0,
                    ),
                    profile(),
                    SizedBox(
                      height: 10.0,
                    ),
                    nickname(),
                    SizedBox(
                      height: 10.0,
                    ),
                  ]),
                ),
              ),
              underline(),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          attendence(),
                          stackpoint(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          wise(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget profile() {
    return CircleAvatar(
      radius: 50.0,
      child: Container(
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                image: new NetworkImage(widget.profileURL))),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget nickname() {
    return Text(widget.nickname,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          //fontWeight: FontWeight.bold,
        ));
  }

  Widget underline() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Container(
        height: 1.0,
        width: 300.0,
        color: Colors.grey,
      ),
    );
  }

  Widget attendence() {
    return Container(
      width: 150,
      height: 175,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffF7F7F7),
        // border: Border.all(
        //   color: Colors.blue,
        //   width: 5,
        // ),
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 0,
            blurRadius: 5.0,
            offset: Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
            child: Text("34%",style: TextStyle(fontSize : 45, fontWeight: FontWeight.bold),),
          ),
          Text("이번달 출석률",style: TextStyle(color: Color(0xff787878), fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  Widget stackpoint() {
    return Container(
      width: 150,
      height: 175,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffF7F7F7),
        // border: Border.all(
        //   color: Colors.blue,
        //   width: 5,
        // ),
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 0,
            blurRadius: 5.0,
            offset: Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
            child: Text("68점",style: TextStyle(fontSize : 45, fontWeight: FontWeight.bold),),
          ),
          Text("누적 평균 점수",style: TextStyle(color: Color(0xff787878), fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  Widget wise() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Container(
        width: 310,
        height: 130,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color(0xffF7F7F7),
          // border: Border.all(
          //   color: Colors.blue,
          //   width: 5,
          // ),

          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 0,
              blurRadius: 5.0,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        child: Center(child: Text("오늘의 명언")),
      ),
    );
  }

  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
      //nickname = (user.kakaoAccount?.profile?.nickname).toString();
      //profileURL = (user.kakaoAccount?.profile?.thumbnailImageUrl).toString();
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }
}
