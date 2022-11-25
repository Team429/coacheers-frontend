import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';

part 'coachingDater.g.dart';


@JsonSerializable()
class CoachingData {
  //calander
  CoachingData(this.companyName, this.time, this.background, this.isAllDay,
      this.face_point, this.voice_point)
      : to = time {
    // throw UnimplementedError();
  }

  @JsonKey(
    name: "background",
    fromJson: ColorFromJson,
    toJson: ColorToJson,
  )
  Color background;

  static Color ColorFromJson(input) => Color(input);

  static String ColorToJson(input) => input.toString();

  String companyName;
  DateTime time;
  DateTime to;
  bool isAllDay;
  double face_point;
  double voice_point;

  static Color GREEN = Color(0xFF1ABC9C);

  factory CoachingData.fromJson(Map<String, dynamic> json) =>
      _$CoachingDataFromJson(json);

  Map<String, dynamic> toJson() => _$CoachingDataToJson(this);

  @override
  String toString() {
    return '${DateFormat('yyyy. MM. dd').format(time)} ${companyName} ${(face_point + voice_point) / 2}';
  }
}

late List<CoachingData> coachings = [];

List<CoachingData> getDataSource() {
  // final DateTime today = DateTime.now();
  // final DateTime startTime1 =
  //     DateTime(today.year, today.month, today.day - 10, 9, 0, 0);
  // final DateTime startTime2 =
  //     DateTime(today.year, today.month, today.day - 9, 9, 0, 0);
  // final DateTime startTime3 =
  //     DateTime(today.year, today.month, today.day - 8, 9, 0, 0);
  // final DateTime startTime4 =
  //     DateTime(today.year, today.month, today.day - 7, 9, 0, 0);
  // final DateTime startTime5 =
  //     DateTime(today.year, today.month, today.day - 6, 9, 0, 0);
  // final DateTime startTime6 =
  //     DateTime(today.year, today.month, today.day - 5, 9, 0, 0);
  // final DateTime startTime7 =
  //     DateTime(today.year, today.month, today.day - 4, 9, 0, 0);
  // final DateTime startTime8 =
  //     DateTime(today.year, today.month, today.day - 3, 9, 0, 0);
  // final DateTime startTime9 =
  //     DateTime(today.year, today.month, today.day - 2, 9, 0, 0);
  // final DateTime startTime10 =
  //     DateTime(today.year, today.month, today.day - 1, 9, 0, 0);
  //
  // coachings
  //     .add(CoachingData('넥슨', startTime1, CoachingData.GREEN, false, 75, 25));
  //
  // coachings.add(
  //     CoachingData('SK하이닉스', startTime2, CoachingData.GREEN, false, 83, 41));
  //
  // coachings
  //     .add(CoachingData('농심', startTime3, CoachingData.GREEN, false, 78, 64));
  //
  // coachings
  //     .add(CoachingData('구글', startTime4, CoachingData.GREEN, false, 72, 70));
  //
  // coachings
  //     .add(CoachingData('삼성', startTime5, CoachingData.GREEN, false, 79, 81));
  //
  // coachings
  //     .add(CoachingData('쿠팡', startTime6, CoachingData.GREEN, false, 53, 75));
  //
  // coachings
  //     .add(CoachingData('네이버', startTime7, CoachingData.GREEN, false, 48, 73));
  //
  // coachings
  //     .add(CoachingData('라인', startTime8, CoachingData.GREEN, false, 60, 77));
  //
  // coachings.add(
  //     CoachingData('배달의 민족', startTime9, CoachingData.GREEN, false, 58, 81));
  //
  // coachings
  //     .add(CoachingData('직방', startTime10, CoachingData.GREEN, false, 65, 87));
  // for (int i = 0; i < list_cnt; i++) {
  //   coachings.add(CoachingData(month[i].companyName, month[i].time, CoachingData.GREEN, false,
  //       month[i].face_point, month[i].voice_point));
  // }

  return coachings;
}

class CoachingDataSource extends CalendarDataSource {
  // CoachingDataSource.test() {
  //   appointments = getDataSource();
  // }

  CoachingDataSource(List<CoachingData> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].time;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].companyName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class MonthData {
  //calander
  MonthData(this.companyName, this.time, this.background, this.isAllDay,
      this.face_point, this.voice_point)
      : to = time {
    // throw UnimplementedError();
  }

  Color background;
  String companyName;
  DateTime time;
  DateTime to;
  bool isAllDay;
  double face_point;
  double voice_point;

  static Color GREEN = Color(0xFF1ABC9C);

  @override
  String toString() {
    return '${DateFormat('yyyy. MM. dd').format(time)} ${companyName} ${(face_point + voice_point) / 2}';
  }
}

Future<List<CoachingData>> getMonthDataSource(int id) async {
  late List<MonthData> month = [];

  String url = 'http://localhost:8000/records/searchmonth';
  var jsonEncode2 = jsonEncode({
    "user_id": id,
    "start_date": DateTime(DateTime.now().year, DateTime.now().month, 1).millisecondsSinceEpoch,
    "end_date": DateTime.now().millisecondsSinceEpoch
  });

  http.Response response = await http.post(Uri.parse(url),
      headers: <String, String>{"content-type": "application/json"},
      body: jsonEncode2);

  var decode = utf8.decode(response.bodyBytes);

  int list_cnt = json.decode(decode).length;

  //print("오잉:${json.decode(decode)}");

  try {
    //print(decode[0].length);
    for (int i = 0; i < list_cnt; i++) {
      DateTime Date = DateTime.parse(json.decode(decode)[i]['created_at']);
      print(Date);
      //print(Date.add(Duration(hours : 9)));
      String companyName = json.decode(decode)[i]["label"];
      double face_point = json.decode(decode)[i]["face_score"];
      double voice_point = json.decode(decode)[i]["voice_score"];
      month.add(MonthData(companyName, Date, CoachingData.GREEN, false,
          face_point, voice_point));
      coachings.add(CoachingData(companyName, Date, CoachingData.GREEN, false, face_point, voice_point));
    }
  } catch (error) {
    print('기록이 없어서 데이터에 아무것도 안담겨요');
  }

  print(month);

  return coachings;
  // coachings.addAll(month);

}

class SearchData {
  SearchData(this.date, this.companyName, this.totalscore, this.facescore,
      this.voicescore);

  String date;
  String companyName;
  double totalscore;
  double facescore;
  double voicescore;
}

List<SearchData> searchData = [];

class HomeBarChartData {
  HomeBarChartData(this.date, this.total, this.face, this.voice);

  final DateTime date;
  final double? total;
  final double? face;
  final double? voice;
}

class RecordBarChartData {
  RecordBarChartData(this.title, this.score, this.color);

  final String title;
  final double? score;
  final Color color;
}

List<HomeBarChartData> getHomeBarsource() {
  late List<HomeBarChartData> homechartData = [];

  if (getDataSource().length == 0) {
    homechartData.add(HomeBarChartData(DateTime.now(), 0.0, 0.0, 0.0));
    homechartData.add(HomeBarChartData(DateTime.now(), 0.0, 0.0, 0.0));
    homechartData.add(HomeBarChartData(DateTime.now(), 0.0, 0.0, 0.0));
  } else if (getDataSource().length == 1) {
    homechartData.add(HomeBarChartData(
        getDataSource()[getDataSource().length - 1].time,
        (getDataSource()[getDataSource().length - 1].face_point +
                getDataSource()[getDataSource().length - 1].voice_point) /
            2,
        getDataSource()[getDataSource().length - 1].face_point,
        getDataSource()[getDataSource().length - 1].voice_point));
  } else if (getDataSource().length == 2) {
    homechartData.add(HomeBarChartData(
        getDataSource()[getDataSource().length - 1].time,
        (getDataSource()[getDataSource().length - 1].face_point +
                getDataSource()[getDataSource().length - 1].voice_point) /
            2,
        getDataSource()[getDataSource().length - 1].face_point,
        getDataSource()[getDataSource().length - 1].voice_point));
    homechartData.add(HomeBarChartData(
        getDataSource()[getDataSource().length - 2].time,
        (getDataSource()[getDataSource().length - 2].face_point +
                getDataSource()[getDataSource().length - 2].voice_point) /
            2,
        getDataSource()[getDataSource().length - 2].face_point,
        getDataSource()[getDataSource().length - 2].voice_point));
  } else {
    homechartData.add(HomeBarChartData(
        getDataSource()[getDataSource().length - 1].time,
        (getDataSource()[getDataSource().length - 1].face_point +
                getDataSource()[getDataSource().length - 1].voice_point) /
            2,
        getDataSource()[getDataSource().length - 1].face_point,
        getDataSource()[getDataSource().length - 1].voice_point));
    homechartData.add(HomeBarChartData(
        getDataSource()[getDataSource().length - 2].time,
        (getDataSource()[getDataSource().length - 2].face_point +
                getDataSource()[getDataSource().length - 2].voice_point) /
            2,
        getDataSource()[getDataSource().length - 2].face_point,
        getDataSource()[getDataSource().length - 2].voice_point));
    homechartData.add(HomeBarChartData(
        getDataSource()[getDataSource().length - 3].time,
        (getDataSource()[getDataSource().length - 3].face_point +
                getDataSource()[getDataSource().length - 3].voice_point) /
            2,
        getDataSource()[getDataSource().length - 3].face_point,
        getDataSource()[getDataSource().length - 3].voice_point));
  }

  return homechartData;
}

List<HomeBarChartData> homechartData = getHomeBarsource();

class DonutChartData {
  DonutChartData(this.scoreName, this.score, this.color);

  final String scoreName;
  final double score;
  final Color color;
}

List<DonutChartData> getTotalDonutsource() {
  late List<DonutChartData> TotalDonuts = [];
  if (getDataSource().length >= 1) {
    TotalDonuts.add(DonutChartData(
      'Scorename',
      (getDataSource()[getDataSource().length - 1].face_point +
              getDataSource()[getDataSource().length - 1].voice_point) /
          2,
      Color(0xff4F98FF),
    ));
    TotalDonuts.add(DonutChartData(
      'Scorename_empty',
      100 -
          (getDataSource()[getDataSource().length - 1].face_point +
                  getDataSource()[getDataSource().length - 1].voice_point) /
              2,
      Color(0xffD8D8D8),
    ));
  } else {
    TotalDonuts.add(DonutChartData(
      'Scorename',
      0.0,
      Color(0xff4F98FF),
    ));
    TotalDonuts.add(DonutChartData(
      'Scorename_empty',
      100.0,
      Color(0xffD8D8D8),
    ));
  }

  return TotalDonuts;
}

List<DonutChartData> getfaceDonutsource() {
  late List<DonutChartData> faceDonuts = [];
  if (getDataSource().length >= 1) {
    faceDonuts.add(DonutChartData(
      'Scorename',
      getDataSource()[getDataSource().length - 1].face_point,
      Color(0xff4F98FF),
    ));
    faceDonuts.add(DonutChartData(
      'Scorename_empty',
      100 - getDataSource()[getDataSource().length - 1].face_point,
      Color(0xffD8D8D8),
    ));
  } else {
    faceDonuts.add(DonutChartData(
      'Scorename',
      0.0,
      Color(0xff4F98FF),
    ));
    faceDonuts.add(DonutChartData(
      'Scorename_empty',
      100.0,
      Color(0xffD8D8D8),
    ));
  }

  return faceDonuts;
}

List<DonutChartData> getvoiceDonutsource() {
  late List<DonutChartData> voiceDonuts = [];
  if (getDataSource().length >= 1) {
    voiceDonuts.add(DonutChartData(
      'Scorename',
      getDataSource()[getDataSource().length - 1].voice_point,
      Color(0xff4F98FF),
    ));
    voiceDonuts.add(DonutChartData(
      'Scorename_empty',
      100 - getDataSource()[getDataSource().length - 1].voice_point,
      Color(0xffD8D8D8),
    ));
  } else {
    voiceDonuts.add(DonutChartData(
      'Scorename',
      0,
      Color(0xff4F98FF),
    ));
    voiceDonuts.add(DonutChartData(
      'Scorename_empty',
      100.0,
      Color(0xffD8D8D8),
    ));
  }

  return voiceDonuts;
}

List<DonutChartData> TotalchartData = getTotalDonutsource();

List<DonutChartData> FacechartData = getfaceDonutsource();

List<DonutChartData> VoicechartData = getvoiceDonutsource();
