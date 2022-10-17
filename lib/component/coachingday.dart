import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  final DateTime startTime2 =
  DateTime(today.year, today.month, today.day - 8, 9, 0, 0);
  final DateTime endTime2 = startTime2.add(const Duration(hours: 2));
  final DateTime startTime3 =
  DateTime(today.year, today.month, today.day - 14, 9, 0, 0);
  final DateTime endTime3 = startTime3.add(const Duration(hours: 2));
  final DateTime startTime4 =
  DateTime(today.year, today.month, today.day - 10, 9, 0, 0);
  final DateTime endTime4 = startTime4.add(const Duration(hours: 2));
  final DateTime startTime5 =
  DateTime(today.year, today.month, today.day - 4, 9, 0, 0);
  final DateTime endTime5 = startTime5.add(const Duration(hours: 2));

  meetings.add(Meeting(
      'Conference', startTime, endTime, const Color(0xFF1ABC9C), false));
  meetings.add(Meeting(
      'Conference', startTime2, endTime2, const Color(0xFF1ABC9C), false));
  meetings.add(Meeting(
      'Conference', startTime3, endTime3, const Color(0xFF1ABC9C), false));
  meetings.add(Meeting(
      'Conference', startTime4, endTime4, const Color(0xFF1ABC9C), false));
  meetings.add(Meeting(
      'Conference', startTime5, endTime5, const Color(0xFF1ABC9C), false));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource.test() {
    appointments = _getDataSource();
  }

  MeetingDataSource(List<Meeting> source) {
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
    return appointments![index].eventName;
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

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}