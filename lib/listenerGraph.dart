import 'dart:math';

import 'package:flutter/material.dart';
import 'graphPainter.dart';
import 'point.dart';
import 'dart:async';

class ListenerGraph<T extends num, V extends Comparable<V>>
    extends StatefulWidget {
  final List<Point<T, V>> points;
  final GraphController<T, V> controller;
  final num stepSize;
  final Paint? linePaint;
  final double? padding;
  const ListenerGraph(
      {Key? key,
      required this.points,
      required this.controller,
      required this.stepSize,
      this.linePaint,
      this.padding})
      : super(key: key);
  @override
  _ListenerGraph createState() => _ListenerGraph();
}

class _ListenerGraph extends State<ListenerGraph> {
  late final GraphController controller;
  late final Timer t;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controller._init(widget.points);
    controller.addListener((points, added) {
      setState(() {});
    });
    t = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      controller.addPoint(
          Point<num, num>(Random().nextInt(50 * 50), 101 + timer.tick));
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print(controller.points.last.value);
    return CustomPaint(
      painter: ListenerGraphPainter(
          padding: widget.padding,
          points: controller.points,
          stepSize: widget.stepSize),
    );
  }
}

typedef GraphListener<T extends num, V extends Comparable<V>> = void Function(
    Iterable<Point<T, V>> points, Point<T, V> added);

class GraphController<T extends num, V extends Comparable<V>> {
  final List<Point<T, V>> points = [];
  final List<GraphListener<T, V>> _listeners = [];
  final GraphAddType addType;
  GraphController({this.addType = GraphAddType.STACK_POP});
  void _init(Iterable<Point<T, V>> values) {
    points.addAll(values);
  }

  void addPoint(Point<T, V> point) {
    if (addType == GraphAddType.STACK_POP) {
      points.removeAt(0);
    }
    points.add(point);
    notifyListeners(added: point);
  }

  void addListener(GraphListener<T, V> listener) {
    _listeners.add(listener);
  }

  void notifyListeners({Point<T, V>? added}) {
    added ??= points.last;
    for (var i in _listeners) {
      i(points, added);
    }
  }

  void dispose() {
    _listeners.clear();
    points.clear();
  }
}

enum GraphAddType { STACK_POP, ADD }

class ListenerGraphPainter extends GraphPainter {
  final List<Point> points;
  final num stepSize;
  final Paint? linePaint;
  ListenerGraphPainter(
      {required this.points,
      required this.stepSize,
      double? padding,
      this.linePaint})
      : super(
            points: points,
            stepSize: stepSize,
            padding: padding ?? 30,
            linePaint: linePaint);
  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return true;
  }
}
