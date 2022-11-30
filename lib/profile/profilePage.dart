import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

String Server_URL = 'https://6edb-210-113-120-46.jp.ngrok.io';

class ProfilePage extends StatefulWidget {
  final int id;
  final String nickname;
  final String profileURL;

  const ProfilePage(
      {Key? key,
      required this.id,
      required this.nickname,
      required this.profileURL})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    print("메인 페이지 - 프로필 페이지\n");
    //_get_user_info();
    // Future<int> count = get_attendance_count_info(widget.id);
    // count.then((value) =>
    //     //print(value)
    // );
    //print(count);

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
            // child: Text("34%".toString(),style: TextStyle(fontSize : 45, fontWeight: FontWeight.bold),),
            child: FutureBuilder(
                future: get_attendance_count_info(widget.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  DateTime now = DateTime.now();
                  int date = now.day;
                  if (snapshot.hasData == false) {
                    return Text(
                      "0%",
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  return Text(
                    "${(snapshot.data / date * 100).toStringAsFixed(1).toString()}%",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  );
                }),
          ),
          Text(
            "이번달 출석률",
            style: TextStyle(
                color: Color(0xff787878), fontWeight: FontWeight.bold),
          ),
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
            child: FutureBuilder(
                future: get_records_month(widget.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) {
                    return Text(
                      "0 점",
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  return Text(
                    '${snapshot.data.toStringAsFixed(1)}점',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  );
                }),
          ),
          Text(
            "누적 평균 점수",
            style: TextStyle(
                color: Color(0xff787878), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget wise() {
    read_wise();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Container(
          width: 310,
          height: 150,
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
          child: FutureBuilder(
              future: read_wise(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData == false) {
                  return Text(
                    "0%",
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                      child: Text(
                        "오늘의 명언",
                        style: TextStyle(
                            color: Color(0xff787878),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Center(
                          child: Text(
                        "${snapshot.data[1]}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(240, 0, 0, 0),
                        child: Text(
                          "${snapshot.data[0]}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                );
              })),
    );
  }

  Future<int> get_attendance_count_info(int id) async {
    String url = '${Server_URL}/attendances/searchmonth';
    var jsonEncode2 = jsonEncode({
      "user_id": id,
      "start_date": DateTime(DateTime.now().year, DateTime.now().month, 1)
          .millisecondsSinceEpoch,
      "end_date": DateTime.now().millisecondsSinceEpoch
    });
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{"content-type": "application/json"},
        body: jsonEncode2);
    var decode = utf8.decode(response.bodyBytes);
    //print("Response : ${response.statusCode} ${decode}");
    //print(response.headers);
    //print(response.body);

    int count = json.decode(response.body).length;
    //print(count);

    return count;
  }

  Future<List> read_wise() async {
    String jsonString = await rootBundle.loadString('assets/wise.json');
    final jsonResponse = json.decode(jsonString);

    List wise = [];
    //print(jsonResponse.length);
    int leftDice = Random().nextInt(jsonResponse.length);
    //print(leftDice);
    //print(jsonResponse[leftDice]['message']);
    //print(jsonResponse[leftDice]['author']);

    wise.add(jsonResponse[leftDice]['author']);
    wise.add(jsonResponse[leftDice]['message']);
    //print(jsonResponse);

    return wise;
  }

  // void _get_user_info() async {
  //   try {
  //     User user = await UserApi.instance.me();
  //     print('사용자 정보 요청 성공'
  //         '\n회원번호: ${user.id}'
  //         '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
  //     //nickname = (user.kakaoAccount?.profile?.nickname).toString();
  //     //profileURL = (user.kakaoAccount?.profile?.thumbnailImageUrl).toString();
  //   } catch (error) {
  //     print('사용자 정보 요청 실패 $error');
  //   }
  // }

  Future<double> get_records_month(int id) async {
    //print(id);
    String url = '${Server_URL}/records/searchmonth';
    //print(start.millisecondsSinceEpoch);
    //print(end.millisecondsSinceEpoch);
    var jsonEncode2 = jsonEncode({
      "user_id": id,
      "start_date": DateTime(DateTime.now().year, DateTime.now().month, 1)
          .add(Duration(hours: 9))
          .millisecondsSinceEpoch,
      "end_date": DateTime.now().add(Duration(hours: 9)).millisecondsSinceEpoch
    });

    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{"content-type": "application/json"},
        body: jsonEncode2);

    var decode = utf8.decode(response.bodyBytes);

    //print(decode);

    int list_cnt = json.decode(decode).length;

    double stack_point = 0;

    try {
      if (list_cnt != 0) {
        for (int i = 0; i < list_cnt; i++) {
          double face_point = json.decode(decode)[i]["face_score"];
          double voice_point = json.decode(decode)[i]["voice_score"];
          double total_point = (face_point + voice_point) / 2;

          stack_point = stack_point + total_point;
        }

        stack_point = stack_point / list_cnt;
      } else {
        stack_point = 0;
      }
    }
    //print(decode[0].length);
    catch (error) {
      print('기록이 없어서 데이터에 아무것도 안담겨요');
    }

    return stack_point;

    //print(monthcoachings);
  }
}
