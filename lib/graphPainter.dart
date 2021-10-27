import 'package:flutter/material.dart';

import 'pair.dart';
import 'point.dart';

class GraphPainter extends CustomPainter {
  final List<Point> points;
  final num stepSize;
  final double padding;
  Paint _linePaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill
    ..strokeWidth = 3;
  Pair<Point, Point> get minax => minMax(points);
  GraphPainter(
      {Listenable? repaint,
      required this.points,
      required this.stepSize,
      this.padding = 55,
      Paint? linePaint})
      : super(repaint: repaint) {
    points.sort((a, b) => a.valueAt.compareTo(b.valueAt));
    if (linePaint != null) _linePaint = linePaint;
  }
  @override
  void paint(Canvas canvas, Size size) {
    final stepRatio = (minax.second.value - minax.first.value) / stepSize;
    final stepMultiplier = (size.height - padding) / stepRatio;
    final widthBetween = (size.width - padding * 2) / points.length;
    double getHeigth(num value) {
      return (size.height - padding * 0.3 - value * stepMultiplier);
    }

    for (var i = 0; i < points.length - 1; i++) {
      final heigthBefore = getHeigth(points[i].value);
      final heightAfter = getHeigth(points[i + 1].value);
      final widthBefore = padding + widthBetween * (i + 1);
      Offset before = Offset(widthBefore, heigthBefore);
      Offset after = Offset(widthBefore + widthBetween, heightAfter);
      canvas.drawLine(before, after, _linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate != this;
  }
}
