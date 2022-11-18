import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:coacheers/component/coachingDater.dart';

class RecordBarchart extends StatefulWidget {
  double totalsum;
  double facesum;
  double voicesum;

  RecordBarchart(this.totalsum,this.facesum,this.voicesum);

  @override
  State<RecordBarchart> createState() => _RecordBarchartState();
}

class _RecordBarchartState extends State<RecordBarchart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(primaryXAxis: CategoryAxis(), series: <ChartSeries>[
      // Renders bar chart
      ColumnSeries<RecordBarChartData, String>(
          dataSource: [
            RecordBarChartData('Total',widget.totalsum, Color(0xff2980B9)),
            RecordBarChartData('표정', widget.facesum, Color(0xff3498DB)),
            RecordBarChartData('목소리', widget.voicesum, Color(0xff1ABC9C)),
          ],
          xValueMapper: (RecordBarChartData data, _) => data.title,
          yValueMapper: (RecordBarChartData data, _) => data.score,
          pointColorMapper: (RecordBarChartData data, _) => data.color,
          animationDuration: 1000,
          width: 0.8,
          // Spacing between the bars
          spacing: 0.3)
    ]);
  }
}

