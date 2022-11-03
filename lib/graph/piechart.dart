import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class Donutchart extends StatelessWidget {

  final double Percent;

  Donutchart(this.Percent);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', Percent, Color(0xff4F98FF)),
      ChartData('Steve', 100-Percent, Color(0xffD8D8D8)),
    ];
    String percentage = Percent.toString();
    final size = 100.0;
    return Container(
        width: size,
        height: size,
        child: SfCircularChart(
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                  widget: Container(
                    child: Text('$percentage%',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),))
            ],
            series: <CircularSeries>[
              // Renders doughnut chart
              DoughnutSeries<ChartData, String>(
                  dataSource: chartData,
                  pointColorMapper:(ChartData data,  _) => data.color,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  radius: '125%',
                  innerRadius: '75%',
                  animationDuration: 1000
              )
            ]
        )
    );
  }

}
class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}