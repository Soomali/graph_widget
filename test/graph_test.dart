import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:graph/graph.dart';

void main() {
  test('adds one to input values', () {
    runApp(TestApp());
  });
}

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: SetGraph<int, num>(values: [Point(2, 5)]),
      )),
    );
  }
}
