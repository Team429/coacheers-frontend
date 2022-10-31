import 'package:flutter/material.dart';

const TWO_PI = 3.14 * 2;


class Donut extends StatelessWidget {

  final double Percent;

  Donut(this.Percent);

  @override
  Widget build(BuildContext context) {
    final size = 100.0;
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: Percent / 100),
      duration: Duration(seconds: 1),
      builder: (context, value, child) {
        int percentage = (value * 100).ceil();
        return Container(
          width: size,
          height: size,
          // color: Color(0xff7fb1f8),
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return SweepGradient(
                      startAngle: 0.0,
                      endAngle: TWO_PI,
                      stops: [value, value],
                      // 0.0 , 0.5 , 0.5 , 1.0
                      center: Alignment.center,
                      colors: [Colors.white, Colors.grey.withAlpha(55)]
                  ).createShader(rect);
                },
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff4F98FF),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: size - 20,
                  height: size - 20,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: Center(child: Text("$percentage%",
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
