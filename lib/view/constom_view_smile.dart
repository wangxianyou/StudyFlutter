import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyPaint extends CustomPainter {
  double _startAngle;
  double _sweepAngle;
  MyPaint(double _startAngle,double _sweepAngle){
    this._startAngle = _startAngle;
    this._sweepAngle = _sweepAngle;
  }
  @override
  void paint(Canvas canvas, Size size) {
    var r = math.min(size.width, size.height);
    Paint paint = new Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Offset.zero & Size(r, r), _startAngle, _sweepAngle, false,
    paint);
  }

  @override
  bool shouldRepaint(MyPaint other) {
    // TODO: implement shouldRepaint
    bool b = _startAngle != other._startAngle || _sweepAngle != other
        ._sweepAngle;
    return b;
  }
}
