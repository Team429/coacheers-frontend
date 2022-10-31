import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

String nickname = "";
String profileURL = "";

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
      nickname = (user.kakaoAccount?.profile?.nickname).toString();
      profileURL = (user.kakaoAccount?.profile?.thumbnailImageUrl).toString();
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("메인 페이지 - 프로필 페이지\n");
    _get_user_info();
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
                      height: 28.0,
                    ),
                    CircleAvatar(
                      radius: 50.0,
                      child: Container(
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                image: new NetworkImage("$profileURL"))),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('$nickname',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Text(
                    //   'S Class Mage',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 15.0,
                    //   ),
                    // )
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Container(
                  height: 1.0,
                  width: 300.0,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 165,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            child: Text("이번달 출석률"),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 5,
                                )),
                          ),
                          Container(
                            width: 140,
                            height: 165,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            child: Text("누적 평균 점수"),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 5,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Container(
                              width: 300,
                              height: 120,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(5),
                              child: Text("오늘의 명언"),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 5,
                                  )),
                            ),
                          ),
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
}
