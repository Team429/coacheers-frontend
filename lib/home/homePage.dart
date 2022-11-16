import 'dart:convert';
import 'package:coacheers/component/kakaoLogin.dart';
import 'package:http/http.dart' as http;
import 'package:coacheers/component/coachingDater.dart';
import 'package:coacheers/component/graph/FaceDonut.dart';
import 'package:coacheers/component/graph/TotalDonut.dart';
import 'package:coacheers/component/graph/VoiceDonut.dart';
import 'package:coacheers/component/graph/homebarchart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var list = [];
  @override
  Widget build(BuildContext context) {
    print("메인 페이지 - 홈 페이지\n");
    get();
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
            Container(
              child: Row(
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
                              fontWeight: FontWeight.bold, fontSize: 15),
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
                              fontWeight: FontWeight.bold, fontSize: 15),
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
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget calander() {
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
            child: SfCalendar(
              view: CalendarView.month,
              todayHighlightColor: Color(0xff4F98FF),
              cellBorderColor: Colors.white,
              headerHeight: 0,
              dataSource: CoachingDataSource.test(),
              monthViewSettings: MonthViewSettings(
                //appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                //showAgenda: true,
                appointmentDisplayCount: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget threedaysbarchart() {
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          HomeBarchart(),
        ],
      ),
    );
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

  void get() async {
    String url = 'http://localhost:8000/users';
    var response = await http.get(Uri.parse(url));
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);

    Map<String, dynamic> user = jsonDecode(responseBody);

    // print("statusCode: ${statusCode}");
    // print("responseHeader: ${responseHeaders}");
    //print("responseBody: ${responseBody}");

    print(user);
    print(user['1']);

    Map<String, dynamic> user_info = jsonDecode(user['1']);
    print(user_info['name']);
  }

}


