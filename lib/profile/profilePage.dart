import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      backgroundImage: AssetImage('assets/user.jpg'),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('사용자',
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