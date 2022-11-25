import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coacheers/component/coachingDater.dart';
import 'package:coacheers/component/graph/FaceDonut.dart';
import 'package:coacheers/component/graph/TotalDonut.dart';
import 'package:coacheers/component/graph/VoiceDonut.dart';
import 'package:coacheers/component/graph/homebarchart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatefulWidget {
  final int id;

  const Home({Key? key, required this.id}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //var list = [];
  List<CoachingData> coachData = getDataSource();

  @override
  Widget build(BuildContext context) {
    print("메인 페이지 - 홈 페이지\n");
    get_user();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          underline(),
          daydonutgraph(),
          underline(),
          calander(),
          underline(),
          threedaysbarchart(),
          underline(),
          feedback(),
        ],
      ),
    );
  }

  Widget underline() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Container(
        height: 1.0,
        width: 300.0,
        color: Colors.grey,
      ),
    );
  }

  Widget daydonutgraph() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: 200,
        height: 200,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
              child: Row(
                children: [
                  Image(image: AssetImage('assets/recent.png'), width: 24),
                  Container(
                    child: Text(
                      " 최근 코치 기록",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: getMonthDataSource(widget.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                  if (snapshot.hasData == false) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }
                  // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                  else {
                    return Container(
                        child: coachData.length > 0
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: TotalDonutchart(),
                                    ),
                                  ),
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: FaceDonutchart(),
                                    ),
                                  ),
                                  Text(
                                    "표정",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: VoiceDonutchart(),
                                    ),
                                  ),
                                  Text(
                                    "목소리",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                            : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Center(
                              child: Text(
                                "데이터가 없습니다.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                        ));
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget calander() {
    Future<List<CoachingData>> monthData = getMonthDataSource(widget.id);
    monthData.then((value) => print(value));
    return Container(
      width: 200,
      height: 360,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
            child: Row(
              children: [
                Image(image: AssetImage('assets/calendar.png'), width: 24),
                Container(
                  child: Text(
                    " 이번달 출석부",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: FutureBuilder(
                future: getMonthDataSource(widget.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                  if (snapshot.hasData == false) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }
                  // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                  else {
                    return SfCalendar(
                      view: CalendarView.month,
                      todayHighlightColor: Color(0xff4F98FF),
                      cellBorderColor: Colors.white,
                      headerHeight: 0,
                      dataSource: CoachingDataSource(getDataSource()),
                      monthViewSettings: MonthViewSettings(
                        //appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                        //showAgenda: true,
                        appointmentDisplayCount: 1,
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget threedaysbarchart() {
    // print(coachData.length);
    return Container(
        width: 200,
        height: 360,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
              child: Row(
                children: [
                  Image(image: AssetImage('assets/chart.png'), width: 24),
                  Container(
                    child: Text(
                      " 일간 기록",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: getMonthDataSource(widget.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                  if (snapshot.hasData == false) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }
                  // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                  else {
                    return Container(
                        child: coachData.length >= 1 ?
                        HomeBarchart()
                            :
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                            child: Center(
                                child: Text(
                                  "데이터가 없습니다.",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )))

                    );
                  }
                }),
          ],
        ));
  }

  Widget feedback() {
    return Container(
      width: 200,
      height: 200,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Text(' 주간 간단 피드백'),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 5,
          )),
    );
  }

  void get_user() async {
    String url = 'http://localhost:8000/users';
    var response = await http.get(Uri.parse(url));
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);

    final user = jsonDecode(responseBody);

    print("statusCode: ${statusCode}");
    //print("responseHeader: ${responseHeaders}");
    //print("responseBody: ${responseBody}");

    print(user[0]['email']);
    //print(responseBody[0]);

    // Map<String, dynamic> user_info = jsonDecode(user['1']);
    // print(user_info['name']);
  }

  void get_records_month() async {
    String url = 'http://localhost:8000/records/searchmonth';
    var response = await http.get(Uri.parse(url));
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);

    //Map<String, dynamic> user = jsonDecode(responseBody);

    print("statusCode: ${statusCode}");
    print("responseHeader: ${responseHeaders}");
    print("responseBody: ${responseBody}");

    //print(user);
    // print(user['1']);

    // Map<String, dynamic> user_info = jsonDecode(user['1']);
    // print(user_info['name']);
  }

// void _get_user_info() async {
//   try {
//     User user = await UserApi.instance.me();
//     user_code = user.id.toString();
//     print("user_code${user_code}");
//     print('사용자 정보 요청 성공'
//         '\n회원번호: ${user.id}'
//         '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
//         '\n프로필사진링크 : ${user.kakaoAccount?.profile?.thumbnailImageUrl}');
//   } catch (error) {
//     print('사용자 정보 요청 실패 $error');
//   }
// }
}
