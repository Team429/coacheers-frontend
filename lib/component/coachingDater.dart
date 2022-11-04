import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:ui';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoachingData {
  //calander
  CoachingData(this.companyName, this.from, this.to, this.background, this.isAllDay, this.face_point,this.voice_point);
  String companyName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  double face_point;
  double voice_point;
}

List<CoachingData> _getDataSource() {
  final List<CoachingData> coachings = <CoachingData>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day - 5, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  final DateTime startTime2 =
  DateTime(today.year, today.month, today.day - 4, 9, 0, 0);
  final DateTime endTime2 = startTime2.add(const Duration(hours: 2));
  final DateTime startTime3 =
  DateTime(today.year, today.month, today.day - 3, 9, 0, 0);
  final DateTime endTime3 = startTime3.add(const Duration(hours: 2));
  final DateTime startTime4 =
  DateTime(today.year, today.month, today.day - 2, 9, 0, 0);
  final DateTime endTime4 = startTime4.add(const Duration(hours: 2));
  final DateTime startTime5 =
  DateTime(today.year, today.month, today.day - 1, 9, 0, 0);
  final DateTime endTime5 = startTime5.add(const Duration(hours: 2));

  coachings.add(CoachingData(
      '넥슨', startTime, endTime, const Color(0xFF1ABC9C), false, 75, 25));
  coachings.add(CoachingData(
      'SK하이닉스', startTime2, endTime2, const Color(0xFF1ABC9C), false, 83, 41));
  coachings.add(CoachingData(
      '농심', startTime3, endTime3, const Color(0xFF1ABC9C), false, 78, 64));
  coachings.add(CoachingData(
      '구글', startTime4, endTime4, const Color(0xFF1ABC9C), false, 72, 70));
  coachings.add(CoachingData(
      '삼성', startTime5, endTime5, const Color(0xFF1ABC9C), false, 79, 81));

  return coachings;
}

class CoachingDataSource extends CalendarDataSource {
  CoachingDataSource.test() {
    appointments = _getDataSource();
  }

  CoachingDataSource(List<CoachingData> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
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

class BarChartData {
  BarChartData(this.date, this.total, this.face, this.voice);
  final String date;
  final double? total;
  final double? face;
  final double? voice;
}

List<BarChartData> chartData = <BarChartData>[
  BarChartData('Today', 50, 75, 25),
  BarChartData('10.27', 62, 83, 41),
  BarChartData('10.26', 71, 78, 64),
];

class DonutChartData {
  DonutChartData(this.scoreName, this.score, this.color);
  final String scoreName;
  final double score;
  final Color color;

}

List<DonutChartData> TotalchartData = [
  DonutChartData('Scorename',
(_getDataSource()[_getDataSource().length - 1].face_point +
          _getDataSource()[_getDataSource().length - 1].voice_point)/2
      , Color(0xff4F98FF),
  ),
  DonutChartData('Scorename_empty',100-
      (_getDataSource()[_getDataSource().length - 1].face_point +
          _getDataSource()[_getDataSource().length - 1].voice_point)/2,
      Color(0xffD8D8D8),),
];

List<DonutChartData> FacechartData = [
  DonutChartData('Scorename',
      _getDataSource()[_getDataSource().length - 1].face_point,
Color(0xff4F98FF),
      ),
  DonutChartData('Scorename_empty',
      100-_getDataSource()[_getDataSource().length - 1].face_point
      , Color(0xffD8D8D8),),
];

List<DonutChartData> VoicechartData = [
  DonutChartData('Scorename',_getDataSource()[_getDataSource().length - 1].voice_point,
      Color(0xff4F98FF),
      ),
  DonutChartData('Scorename_empty',100-_getDataSource()[_getDataSource().length - 1].voice_point,
      Color(0xffD8D8D8),),
];