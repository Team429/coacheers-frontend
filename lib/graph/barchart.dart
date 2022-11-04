import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../component/coachingDater.dart';


class Barchart extends StatefulWidget {

  Barchart({Key? key}) : super(key: key);

  _BarchartState createState() => _BarchartState();
}

class _BarchartState extends State<Barchart> {
  @override
  Widget build(BuildContext context) {
    return
      SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        palette: <Color>[
          Color(0xff2980B9),
          Color(0xff3498DB),
          Color(0xff1ABC9C)
        ],
        series: <CartesianSeries>[
          ColumnSeries<BarChartData, String>(
            dataSource: chartData,
            xValueMapper: (BarChartData data, _) => data.date,
            yValueMapper: (BarChartData data, _) => data.total,
            animationDuration: 1000,
              width: 0.8,
              // Spacing between the bars
              spacing: 0.3
          ),
          ColumnSeries<BarChartData, String>(
            dataSource: chartData,
            xValueMapper: (BarChartData data, _) => data.date,
            yValueMapper: (BarChartData data, _) => data.face,
            animationDuration: 1000,
              width: 0.8,
              // Spacing between the bars
              spacing: 0.3
          ),
          ColumnSeries<BarChartData, String>(
            dataSource: chartData,
            xValueMapper: (BarChartData data, _) => data.date,
            yValueMapper: (BarChartData data, _) => data.voice,
            animationDuration: 1000,
              width: 0.8,
              // Spacing between the bars
              spacing: 0.3
          )
        ]
    );
  }
}
