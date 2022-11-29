import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';

class MonthCoachingData {
  //calander
  MonthCoachingData(this.companyName, this.time, this.background, this.isAllDay,
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

late List<MonthCoachingData> monthcoachings = [];

List<MonthCoachingData> getmonthDataSource() {
  return monthcoachings;
}

class MonthCoachingDataSource extends CalendarDataSource {
  MonthCoachingDataSource.test() {
    appointments = getmonthDataSource();
  }

  MonthCoachingDataSource(List<MonthCoachingData> source) {
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

  @override
  String toString() {
    return '${DateFormat('yyyy. MM. dd').format(time)} ${companyName} ${(face_point + voice_point) / 2}';
  }
}

late List<CoachingData> coachings = [];

List<CoachingData> getdataSource() {
  //print(coachings);

  return coachings;
}

class SearchData {
  SearchData(this.record_index, this.video_id, this.date, this.companyName,
      this.totalscore, this.facescore, this.voicescore);

  int record_index;
  int video_id;
  DateTime date;
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
  if (getdataSource().length == 0) {
    homechartData.add(HomeBarChartData(DateTime.now(), 0.0, 0.0, 0.0));
    homechartData.add(HomeBarChartData(DateTime.now(), 0.0, 0.0, 0.0));
    homechartData.add(HomeBarChartData(DateTime.now(), 0.0, 0.0, 0.0));
  } else if (getdataSource().length == 1) {
    homechartData.add(HomeBarChartData(
        getdataSource()[getdataSource().length - 1].time,
        (getdataSource()[getdataSource().length - 1].face_point +
                getdataSource()[getdataSource().length - 1].voice_point) /
            2,
        getdataSource()[getdataSource().length - 1].face_point,
        getdataSource()[getdataSource().length - 1].voice_point));
  } else if (getdataSource().length == 2) {
    homechartData.add(HomeBarChartData(
        getdataSource()[getdataSource().length - 1].time,
        (getdataSource()[getdataSource().length - 1].face_point +
                getdataSource()[getdataSource().length - 1].voice_point) /
            2,
        getdataSource()[getdataSource().length - 1].face_point,
        getdataSource()[getdataSource().length - 1].voice_point));
    homechartData.add(HomeBarChartData(
        getdataSource()[getdataSource().length - 2].time,
        (getdataSource()[getdataSource().length - 2].face_point +
                getdataSource()[getdataSource().length - 2].voice_point) /
            2,
        getdataSource()[getdataSource().length - 2].face_point,
        getdataSource()[getdataSource().length - 2].voice_point));
  } else {
    homechartData.add(HomeBarChartData(
        getdataSource()[getdataSource().length - 1].time,
        (getdataSource()[getdataSource().length - 1].face_point +
                getdataSource()[getdataSource().length - 1].voice_point) /
            2,
        getdataSource()[getdataSource().length - 1].face_point,
        getdataSource()[getdataSource().length - 1].voice_point));
    homechartData.add(HomeBarChartData(
        getdataSource()[getdataSource().length - 2].time,
        (getdataSource()[getdataSource().length - 2].face_point +
                getdataSource()[getdataSource().length - 2].voice_point) /
            2,
        getdataSource()[getdataSource().length - 2].face_point,
        getdataSource()[getdataSource().length - 2].voice_point));
    homechartData.add(HomeBarChartData(
        getdataSource()[getdataSource().length - 3].time,
        (getdataSource()[getdataSource().length - 3].face_point +
                getdataSource()[getdataSource().length - 3].voice_point) /
            2,
        getdataSource()[getdataSource().length - 3].face_point,
        getdataSource()[getdataSource().length - 3].voice_point));
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
  if (getdataSource().length >= 1) {
    TotalDonuts.add(DonutChartData(
      'Scorename',
      (getdataSource()[getdataSource().length - 1].face_point +
              getdataSource()[getdataSource().length - 1].voice_point) /
          2,
      Color(0xff4F98FF),
    ));
    TotalDonuts.add(DonutChartData(
      'Scorename_empty',
      100 -
          (getdataSource()[getdataSource().length - 1].face_point +
                  getdataSource()[getdataSource().length - 1].voice_point) /
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
  if (getdataSource().length >= 1) {
    faceDonuts.add(DonutChartData(
      'Scorename',
      getdataSource()[getdataSource().length - 1].face_point,
      Color(0xff4F98FF),
    ));
    faceDonuts.add(DonutChartData(
      'Scorename_empty',
      100 - getdataSource()[getdataSource().length - 1].face_point,
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
  if (getdataSource().length >= 1) {
    voiceDonuts.add(DonutChartData(
      'Scorename',
      getdataSource()[getdataSource().length - 1].voice_point,
      Color(0xff4F98FF),
    ));
    voiceDonuts.add(DonutChartData(
      'Scorename_empty',
      100 - getdataSource()[getdataSource().length - 1].voice_point,
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
