import 'package:coacheers/component/coachingDater.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FaceDonutchart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String percent = FacechartData[TotalchartData.length - 2]
        .score
        .toStringAsFixed(1)
        .toString();
    final size = 100.0;
    return Container(
        width: size,
        height: size,
        child: SfCircularChart(annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
              widget: Container(
            child: Text(
              '$percent%',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ))
        ], series: <CircularSeries>[
          // Renders doughnut chart
          DoughnutSeries<DonutChartData, String>(
              dataSource: FacechartData,
              pointColorMapper: (DonutChartData data, _) => data.color,
              xValueMapper: (DonutChartData data, _) => data.scoreName,
              yValueMapper: (DonutChartData data, _) => data.score,
              radius: '125%',
              innerRadius: '75%',
              animationDuration: 1000)
        ]));
  }
}
