import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:coacheers/component/coachingDater.dart';

class HomeBarchart extends StatefulWidget {
  HomeBarchart({Key? key}) : super(key: key);

  _HomeBarchartState createState() => _HomeBarchartState();
}

class _HomeBarchartState extends State<HomeBarchart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(primaryXAxis: CategoryAxis(), palette: <Color>[
      Color(0xff2980B9),
      Color(0xff3498DB),
      Color(0xff1ABC9C)
    ], series: <CartesianSeries>[
      ColumnSeries<HomeBarChartData, String>(
          dataSource: homechartData,
          xValueMapper: (HomeBarChartData data, _) =>
              DateFormat('MM.dd').format(data.date),
          yValueMapper: (HomeBarChartData data, _) => data.total,
          animationDuration: 1000,
          width: 0.8,
          // Spacing between the bars
          spacing: 0.3),
      ColumnSeries<HomeBarChartData, String>(
          dataSource: homechartData,
          xValueMapper: (HomeBarChartData data, _) =>
              DateFormat('MM.dd').format(data.date),
          yValueMapper: (HomeBarChartData data, _) => data.face,
          animationDuration: 1000,
          width: 0.8,
          // Spacing between the bars
          spacing: 0.3),
      ColumnSeries<HomeBarChartData, String>(
          dataSource: homechartData,
          xValueMapper: (HomeBarChartData data, _) =>
              DateFormat('MM.dd').format(data.date),
          yValueMapper: (HomeBarChartData data, _) => data.voice,
          animationDuration: 1000,
          width: 0.8,
          // Spacing between the bars
          spacing: 0.3)
    ]);
  }
}
