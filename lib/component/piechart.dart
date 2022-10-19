import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PieChart extends CustomPainter {
  int percentage = 0;
  double textScaleFactor = 1.0;
  Color textColor;

  PieChart(
      {required this.percentage,
      required this.textScaleFactor,
      required this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xffD8D8D8)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = min(size.width / 2 - paint.strokeWidth / 2,
        size.height / 2 - paint.strokeWidth / 2);
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);
    drawArc(paint, canvas, center, radius);
    drawText(canvas, size, "$percentage%");
  }

  void drawArc(Paint paint, Canvas canvas, Offset center, double radius) {
    double arcAngle = 2 * pi * (percentage / 100);
    paint..color = Color(0xff4F98FF);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paint);
  }

  void drawText(Canvas canvas, Size size, String text) {
    double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor),
        text: text);
    TextPainter tp = TextPainter(text: sp, textDirection: ui.TextDirection.ltr);

    tp.layout();
    double dx = size.width / 2 - tp.width / 2;
    double dy = size.height / 2 - tp.height / 2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  double getFontSize(Size size, String text) {
    return size.width / text.length * textScaleFactor;
  }

  @override
  bool shouldRepaint(PieChart old) {
    return old.percentage != percentage;
  }
}
