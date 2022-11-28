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

  late List<CoachingData> coachitems = [];
  late List<MonthCoachingData> monthcoachitems = [];
  late int record_index = 0;

  void initState() {

    get_records_threedays(widget.id);
    get_records_month(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("메인 페이지 - 홈 페이지\n");
    //print(coachings);

    //get_user();
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
                child: coachings.length > 0
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
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                )),
            // Container(
            //     child: coachings.length > 0
            //         ? Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Expanded(
            //           flex: 1,
            //           child: Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Container(
            //                   child: TotalDonutchart(),
            //                 ),
            //               ),
            //               Text(
            //                 "Total",
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 15),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Expanded(
            //           flex: 1,
            //           child: Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Container(
            //                   child: FaceDonutchart(),
            //                 ),
            //               ),
            //               Text(
            //                 "표정",
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 15),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Expanded(
            //           flex: 1,
            //           child: Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Container(
            //                   child: VoiceDonutchart(),
            //                 ),
            //               ),
            //               Text(
            //                 "목소리",
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 15),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     )
            //         : Padding(
            //       padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            //       child: Center(
            //           child: Text(
            //             "데이터가 없습니다.",
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold, fontSize: 15),
            //           )),
            //     )),
          ],
        ),
      ),
    );
  }

  Widget calander() {
    //Future<List<MonthCoachingData>> monthData = getMonthDataSource(widget.id);
    //monthData.then((value) => print("켈린더 : ${value}"));
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
              dataSource: MonthCoachingDataSource(getmonthDataSource()),
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
            Container(
                child: coachings.length >= 1
                    ? HomeBarchart()
                    : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                    child: Center(
                        child: Text(
                          "데이터가 없습니다.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )
                    )
                )
            ),
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

    //print("statusCode: ${statusCode}");
    //print("responseHeader: ${responseHeaders}");
    //print("responseBody: ${responseBody}");

    //print(user[0]['email']);
    //print(responseBody[0]);

    // Map<String, dynamic> user_info = jsonDecode(user['1']);
    // print(user_info['name']);
  }

  void get_records_threedays(int id) async {
    //print(id);
    String url = 'http://localhost:8000/records/searchTotal';
    //print(start.millisecondsSinceEpoch);
    //print(end.millisecondsSinceEpoch);
    var jsonEncode2 = jsonEncode({
      "user_id": id,
    });

    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{"content-type": "application/json"},
        body: jsonEncode2);

    var decode = utf8.decode(response.bodyBytes);

    //print(decode);

    int list_cnt = json
        .decode(decode)
        .length;

    //print(list_cnt);
    //print("오잉:${json.decode(decode)[0]['created_at']}");
    //print("내가 원하는 거임 : ${response.body}");
    coachings.clear();

    try {
      //print(decode[0].length);
      for (int i = 0; i < list_cnt; i++) {
        DateTime Date = DateTime.parse(json.decode(decode)[i]['created_at']);
        //print(Date);
        //print(Date.add(Duration(hours : 9)));
        String companyName = json.decode(decode)[i]["label"];
        double face_point = json.decode(decode)[i]["face_score"];
        double voice_point = json.decode(decode)[i]["voice_score"];
        coachings.add(CoachingData(companyName,Date, CoachingData.GREEN, false,
            face_point, voice_point));
      }

      //print(coachings);
      //print(getdataSource().length);

    } catch (error) {
      print('기록이 없어서 데이터에 아무것도 안담겨요');
    }

    setState(() {
      coachitems.clear();
      coachitems.addAll(coachings);
    });

  }

  void get_records_month(int id) async {
    //print(id);
    String url = 'http://localhost:8000/records/searchmonth';
    //print(start.millisecondsSinceEpoch);
    //print(end.millisecondsSinceEpoch);
    var jsonEncode2 = jsonEncode({
      "user_id": id,
      "start_date": DateTime(DateTime.now().year, DateTime.now().month, 1).millisecondsSinceEpoch,
      "end_date": DateTime.now().millisecondsSinceEpoch
    });

    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{"content-type": "application/json"},
        body: jsonEncode2);

    var decode = utf8.decode(response.bodyBytes);

    //print(decode);

    int list_cnt = json.decode(decode).length;

    //print(json.decode(decode));
    //print(list_cnt);
    //print("오잉:${json.decode(decode)[0]['created_at']}");
    //print("내가 원하는 거임 : ${response.body}");
    monthcoachings.clear();

    try {
      //print(decode[0].length);
      for (int i = 0; i < list_cnt; i++) {
        DateTime Date = DateTime.parse(json.decode(decode)[i]['created_at']);
        //print(Date);
        //print(Date.add(Duration(hours : 9)));
        String companyName = json.decode(decode)[i]["label"];
        double face_point = json.decode(decode)[i]["face_score"];
        double voice_point = json.decode(decode)[i]["voice_score"];
        monthcoachings.add(MonthCoachingData(companyName, Date, CoachingData.GREEN, false,
            face_point, voice_point));
      }

    } catch (error) {
      print('기록이 없어서 데이터에 아무것도 안담겨요');
    }

    setState(() {
      monthcoachitems.clear();
      monthcoachitems.addAll(monthcoachings);
    });

    //print(monthcoachings);
  }
}

