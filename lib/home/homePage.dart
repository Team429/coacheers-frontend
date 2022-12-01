import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coacheers/component/coachingDater.dart';
import 'package:coacheers/component/graph/FaceDonut.dart';
import 'package:coacheers/component/graph/TotalDonut.dart';
import 'package:coacheers/component/graph/VoiceDonut.dart';
import 'package:coacheers/component/graph/homebarchart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

String Server_URL =  'https://42b8-220-117-14-181.jp.ngrok.io';

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
  late int joysum = 0;
  late int surprisedsum = 0;
  late double highsum = 0.0;

  void initState() {

    get_records_threedays(widget.id);
    get_records_month(widget.id);
    get_recodes_week(widget.id);

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
                  Image(
                      image: AssetImage('assets/images/recent.png'), width: 24),
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
                Image(
                    image: AssetImage('assets/images/calendar.png'), width: 24),
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
                  Image(
                      image: AssetImage('assets/images/chart.png'), width: 24),
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
                        )))),
          ],
        ));
  }

  Widget feedback() {
    return FutureBuilder(
      future: get_recodes_week(widget.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Text(
            "피드백 내용이 없습니다.",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return Container(
              width: 200,
              height: 150,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                    child: Row(
                      children: [
                        Image(
                            image: AssetImage('assets/images/support.png'),
                            width: 24),
                        Container(
                          child: Text(
                            "주간 간단 피드백",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                    child: Text(
                      "${snapshot.data[0]}\n${snapshot.data[1]}\n${snapshot.data[2]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  )
                ],
              ));
        }
      },
    );
  }

  void get_user() async {
    String url = '${Server_URL}/users';
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
    String url = '${Server_URL}/records/searchTotal';
    var jsonEncode2 = jsonEncode({
      "user_id": id,
    });

    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{"content-type": "application/json"},
        body: jsonEncode2);

    var decode = utf8.decode(response.bodyBytes);

    int list_cnt = json.decode(decode).length;

    coachings.clear();

    try {
      for (int i = 0; i < list_cnt; i++) {
        DateTime Date = DateTime.parse(json.decode(decode)[i]['created_at']);
        String companyName = json.decode(decode)[i]["label"];
        double face_point = json.decode(decode)[i]["face_score"];
        double voice_point = json.decode(decode)[i]["voice_score"];

        coachings.add(CoachingData(companyName, Date, CoachingData.GREEN, false,
            face_point, voice_point));
      }
    } catch (error) {
      print('기록이 없어서 데이터에 아무것도 안담겨요');
    }

    setState(() {
      coachitems.clear();
      coachitems.addAll(coachings);
    });
  }

  void get_records_month(int id) async {
    String url = '${Server_URL}/records/searchmonth';

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

    int list_cnt = json.decode(decode).length;

    monthcoachings.clear();

    try {
      for (int i = 0; i < list_cnt; i++) {
        DateTime Date = DateTime.parse(json.decode(decode)[i]['created_at']);

        String companyName = json.decode(decode)[i]["label"];
        double face_point = json.decode(decode)[i]["face_score"];
        double voice_point = json.decode(decode)[i]["voice_score"];
        monthcoachings.add(MonthCoachingData(companyName, Date,
            CoachingData.GREEN, false, face_point, voice_point));
      }
    } catch (error) {
      print('기록이 없어서 데이터에 아무것도 안담겨요');
    }

    setState(() {
      monthcoachitems.clear();
      monthcoachitems.addAll(monthcoachings);
    });
  }

  Future<List<String>> get_recodes_week(int id) async {
    String url = '${Server_URL}/records/searchweek';
    var now = DateTime.now();

    var jsonEncode2 = jsonEncode({
      "user_id": id,
      "start_date": DateTime(now.year, now.month, now.day - (now.weekday - 1))
          .millisecondsSinceEpoch,
      "end_date": DateTime(now.year, now.month, now.day + (7 - now.weekday))
          .millisecondsSinceEpoch,
    });

    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{"content-type": "application/json"},
        body: jsonEncode2);

    var decode = utf8.decode(response.bodyBytes);

    int list_cnt = json.decode(decode).length;


      joysum = 0;
      surprisedsum = 0;
      highsum = 0;
      List<String> feedback = [];

      if (list_cnt != 0) {
        for (int i = 0; i < list_cnt; i++) {
          int joy_score = json.decode(decode)[i]["joy_score"];
          //print(joy_score);
          int surprised_score = json.decode(decode)[i]['surprised_score'];
          //print(surprised_score);
          double high_score = json.decode(decode)[i]['high_score'];
          //print(high_score);
          // double intensity_score = json.decode(decode)['intensity_score'];
          joysum = joysum + joy_score;
          surprisedsum = surprisedsum + surprised_score;
          highsum = highsum + high_score;
        }

        joysum = (joysum / list_cnt).round();
        surprisedsum = (surprisedsum / list_cnt).round();
        highsum = (highsum / list_cnt);

        print(joysum);
        print(surprisedsum);
        print(highsum);

        if (joysum >= 60 && joysum < 80) {
          feedback.add("좀 더 밝은 표정을 지어볼까요?");
        } else if (joysum >= 80 && joysum < 90) {
          feedback.add("좀 더 자신감을 가지세요!");
        } else if (joysum >= 90 && joysum < 100) {
          feedback.add("지금 이대로가 좋습니다.");
        } else if (joysum >= 100 && joysum < 110) {
          feedback.add("조금만 차분하게 하면 좋을 것 같아요!");
        } else {
          feedback.add("너무 밝은 표정은 오히려 역효과에요!");
        }

        if (surprisedsum >= 0 && surprisedsum < 5) {
          feedback.add("당황하지 않고 잘 수행했어요!");
        } else if (surprisedsum >= 5 && surprisedsum < 10) {
          feedback.add("적당한 긴장감은 면접에 도움이 될 수 있어요.");
        } else if (surprisedsum >= 10 && surprisedsum < 15) {
          feedback.add("조금만 흥분을 가라앉히고 얘기해봐요");
        } else if (surprisedsum >= 15 && surprisedsum < 20) {
          feedback.add("너무 당황했어요! 진정해요!");
        }

        if (highsum >= 0 && highsum < 20) {
          feedback.add("조금 더 활기차게 말해볼까요?");
        } else if (highsum >= 20 && highsum < 40) {
          feedback.add("아직은 괜찮아요...");
        } else if (highsum >= 40 && highsum < 60) {
          feedback.add("목소리 높이는 적절하네요!");
        } else if (highsum >= 60 && highsum < 80) {
          feedback.add("차분한 목소리로 말해보아요!");
        }

      }
      else {
        joysum = 0;
        surprisedsum = 0;
        highsum = 0;
        feedback.clear();
      }

    return feedback;
  }

}
