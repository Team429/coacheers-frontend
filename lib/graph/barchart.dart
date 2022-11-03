import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class Barchart extends StatefulWidget {

  Barchart({Key? key}) : super(key: key);

  _BarchartState createState() => _BarchartState();
}

class _BarchartState extends State<Barchart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = <ChartData>[
      ChartData('Today', 50, 75, 25),
      ChartData('10.31', 62, 83, 41),
      ChartData('10.27', 71, 78, 64),
    ];

    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        palette: <Color>[
          Color(0xff2980B9),
          Color(0xff3498DB),
          Color(0xff1ABC9C)
        ],
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            animationDuration: 1000,
              width: 0.8,
              // Spacing between the bars
              spacing: 0.3
          ),
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y1,
            animationDuration: 1000,
              width: 0.8,
              // Spacing between the bars
              spacing: 0.3
          ),
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y2,
            animationDuration: 1000,
              width: 0.8,
              // Spacing between the bars
              spacing: 0.3
          )
        ]
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);
  final String x;
  final double? y;
  final double? y1;
  final double? y2;
}