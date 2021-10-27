import 'dart:math';

import 'package:flutter/material.dart';

import 'graphPainter.dart';
import 'point.dart';

class SetGraph<T extends num, V extends Comparable<V>> extends StatelessWidget {
  final List<Point<T, V>> values;
  const SetGraph({Key? key, required this.values}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: GraphPainter(
            stepSize: 1,
            points: List.generate(
                20, (index) => Point<num, num>(Random().nextInt(100), index))));
  }
}
