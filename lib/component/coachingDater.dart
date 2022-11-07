import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:ui';
import 'package:syncfusion_flutter_charts/charts.dart';

final List<DateTime> searchDateList = <DateTime>[];
final List<String> searchCompanyList = <String>[];
final List<String> searchScoreList = <String>[];
final List<double> searchFaceScoreList = <double>[];
final List<double> searchVoiceScoreList = <double>[];

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

  @override
  String toString() {
    return '${DateFormat('yyyy. MM. dd').format(from)} ${companyName} ${(face_point+voice_point) / 2}';
  }
}

List<CoachingData> _getDataSource() {

  searchDateList.clear();
  searchCompanyList.clear();
  searchScoreList.clear();

  late List<CoachingData> coachings = <CoachingData>[];
  final DateTime today = DateTime.now();
  final DateTime startTime1 =
  DateTime(today.year, today.month, today.day - 10, 9, 0, 0);
  final DateTime endTime1 = startTime1.add(const Duration(hours: 2));
  final DateTime startTime2 =
  DateTime(today.year, today.month, today.day - 9, 9, 0, 0);
  final DateTime endTime2 = startTime2.add(const Duration(hours: 2));
  final DateTime startTime3 =
  DateTime(today.year, today.month, today.day - 8, 9, 0, 0);
  final DateTime endTime3 = startTime3.add(const Duration(hours: 2));
  final DateTime startTime4 =
  DateTime(today.year, today.month, today.day - 7, 9, 0, 0);
  final DateTime endTime4 = startTime4.add(const Duration(hours: 2));
  final DateTime startTime5 =
  DateTime(today.year, today.month, today.day - 6, 9, 0, 0);
  final DateTime endTime5 = startTime5.add(const Duration(hours: 2));
  final DateTime startTime6 =
  DateTime(today.year, today.month, today.day - 5, 9, 0, 0);
  final DateTime endTime6 = startTime5.add(const Duration(hours: 2));
  final DateTime startTime7 =
  DateTime(today.year, today.month, today.day - 4, 9, 0, 0);
  final DateTime endTime7 = startTime5.add(const Duration(hours: 2));
  final DateTime startTime8 =
  DateTime(today.year, today.month, today.day - 3, 9, 0, 0);
  final DateTime endTime8 = startTime5.add(const Duration(hours: 2));
  final DateTime startTime9 =
  DateTime(today.year, today.month, today.day - 2, 9, 0, 0);
  final DateTime endTime9 = startTime5.add(const Duration(hours: 2));
  final DateTime startTime10 =
  DateTime(today.year, today.month, today.day - 1, 9, 0, 0);
  final DateTime endTime10 = startTime5.add(const Duration(hours: 2));

  coachings.add(CoachingData(
      '넥슨', startTime1, endTime1, const Color(0xFF1ABC9C), false, 75, 25));
  searchDateList.add(startTime1);

  coachings.add(CoachingData(
      'SK하이닉스', startTime2, endTime2, const Color(0xFF1ABC9C), false, 83, 41));
  searchDateList.add(startTime2);

  coachings.add(CoachingData(
      '농심', startTime3, endTime3, const Color(0xFF1ABC9C), false, 78, 64));
  searchDateList.add(startTime3);

  coachings.add(CoachingData(
      '구글', startTime4, endTime4, const Color(0xFF1ABC9C), false, 72, 70));
  searchDateList.add(startTime4);

  coachings.add(CoachingData(
      '삼성', startTime5, endTime5, const Color(0xFF1ABC9C), false, 79, 81));
  searchDateList.add(startTime5);

  coachings.add(CoachingData(
      '쿠팡', startTime6, endTime6, const Color(0xFF1ABC9C), false, 53, 75));
  searchDateList.add(startTime6);

  coachings.add(CoachingData(
      '네이버', startTime7, endTime7, const Color(0xFF1ABC9C), false, 48, 73));
  searchDateList.add(startTime7);

  coachings.add(CoachingData(
      '라인', startTime8, endTime8, const Color(0xFF1ABC9C), false, 60, 77));
  searchDateList.add(startTime8);

  coachings.add(CoachingData(
      '배달의 민족', startTime9, endTime9, const Color(0xFF1ABC9C), false, 58, 81));
  searchDateList.add(startTime9);

  coachings.add(CoachingData(
      '직방', startTime10, endTime10, const Color(0xFF1ABC9C), false, 65, 87));
  searchDateList.add(startTime10);

  for(int i = 0; i < coachings.length; i++){
    searchCompanyList.add(coachings[i].companyName);
    searchScoreList.add(((coachings[i].voice_point+ coachings[i].face_point)/2).toString());
    searchFaceScoreList.add(coachings[i].face_point);
    searchVoiceScoreList.add(coachings[i].voice_point);
  }

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

List<HomeBarChartData> homechartData = [
  HomeBarChartData(_getDataSource()[_getDataSource().length - 1].from,
      (_getDataSource()[_getDataSource().length - 1].face_point +
      _getDataSource()[_getDataSource().length - 1].voice_point)/2,
      _getDataSource()[_getDataSource().length - 1].face_point,
      _getDataSource()[_getDataSource().length - 1].voice_point),
  HomeBarChartData(_getDataSource()[_getDataSource().length - 2].from,
      (_getDataSource()[_getDataSource().length -2].face_point +
          _getDataSource()[_getDataSource().length - 2].voice_point)/2,
      _getDataSource()[_getDataSource().length - 2].face_point,
      _getDataSource()[_getDataSource().length - 2].voice_point),
  HomeBarChartData(_getDataSource()[_getDataSource().length - 3].from,
      (_getDataSource()[_getDataSource().length - 3].face_point +
          _getDataSource()[_getDataSource().length - 3].voice_point)/2,
      _getDataSource()[_getDataSource().length - 3].face_point,
      _getDataSource()[_getDataSource().length - 3].voice_point),
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
