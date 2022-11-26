import 'package:flutter/material.dart';
import 'package:radar_chart/radar_chart.dart';
import 'dart:math';

class RadarChartExample extends StatefulWidget {
  const RadarChartExample({Key? key}) : super(key: key);

  @override
  _RadarChartExampleState createState() => _RadarChartExampleState();
}

class _RadarChartExampleState extends State<RadarChartExample> {
  int _counter = 5;

  List<double> values = [0.5, 0.3, 0.85, 0.7, 0.3];
  List<String> name = ["표정","크기","높낮이","발음","빠르기"];
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

    vertices2 = [_vertex, _vertex, _vertex, _vertex, _vertex];
  }

  @override
  Widget build(BuildContext context) {
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
            initialAngle: 60,
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