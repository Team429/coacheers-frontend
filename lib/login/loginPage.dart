import 'package:coacheers/frame/mainFrame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../component/kakaoLogin.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xfffffffff),
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Image(
                        image: AssetImage('assets/Coacheers.png'), width: 300),
                    Text(
                      "Coacheers",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainFrame()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage('assets/Facebook.png'),
                                    width: 40,
                                  ),
                                  Text(
                                    "Facebook 로그인",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color(0xff569BF5),
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Color(0xff569BF5))))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            // onPressed: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const MainFrame()),
                            //   );
                            // },
                            onPressed: () {
                              KakaoLogin(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      image: AssetImage('assets/kakaotalk.png'),
                                      width: 40),
                                  Text(
                                    "Kakao 로그인",
                                    style: TextStyle(
                                      color: Color(0xff392020),
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffFEE500)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Color(0xffFEE500))))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainFrame()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image: AssetImage('assets/Google.png'),
                                    width: 40),
                                Text(
                                  "Google 로그인",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xffF7F7F7)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: Color(0xffF7F7F7))))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(),
      ),
    );
  }
}
