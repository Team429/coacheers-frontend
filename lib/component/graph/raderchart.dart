import 'package:flutter/material.dart';
import 'package:radar_chart/radar_chart.dart';
import 'dart:math';

class RadarChartExample extends StatefulWidget {
  final double joy_score;
  final double surprised_score;
  final double high_score;
  final double intensity_score;

  RadarChartExample({Key? key, required this.joy_score,required this.high_score, required this.surprised_score, required this.intensity_score}) : super(key: key);

  @override
  _RadarChartExampleState createState() => _RadarChartExampleState();
}

class _RadarChartExampleState extends State<RadarChartExample> {
  int _counter = 4;

  List<double> values = [0.0,0.0,0.0,0.0];
  List<String> name = ["긍정", "당황", "높이", "크기"];
  late List<PreferredSizeWidget> vertices2;
  late PreferredSizeWidget _vertex;

  @override
  void initState() {
    super.initState();
    const double radius = 5;
    _vertex = PreferredSize(
      preferredSize: const Size.square(2 * radius),
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: radius,
      ),
    );

    vertices2 = [_vertex, _vertex, _vertex, _vertex];
  }

  @override
  Widget build(BuildContext context) {
    values = [widget.joy_score/100, widget.surprised_score * 5/100, widget.high_score/100, widget.intensity_score/100];
    print(values);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          ),
          RadarChart(
            length: _counter,
            radius: 120,
            initialAngle: 0,
            backgroundColor: Colors.white,
            borderStroke: 2,
            borderColor: Colors.grey.shade300,
            radialStroke: 2,
            radialColor: Colors.grey.shade300,
            vertices: [
              for (int i = 0; i < _counter; i++)
                RadarVertex(
                  radius: 0,
                  textOffset: Offset(0, 0),
                  text: Text(
                    '${name[i]}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
            ],
            radars: [
              RadarTile(
                values: values,
                borderStroke: 2,
                borderColor: Colors.blue,
                backgroundColor: Colors.blue.withOpacity(0.4),
                vertices: vertices2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RadarVertex extends StatelessWidget with PreferredSizeWidget {
  const RadarVertex({
    required this.radius,
    this.text,
    this.textOffset,
  });

  final double radius;
  final Widget? text;
  final Offset? textOffset;

  @override
  Size get preferredSize => Size.fromRadius(radius);

  @override
  Widget build(BuildContext context) {
    Widget tree = CircleAvatar(
      radius: radius,
      backgroundColor: Colors.green,
    );
    if (text != null) {
      tree = Stack(
        children: [
          tree,
          Center(
            child: text,
          )
        ],
      );
    }
    return tree;
  }
}