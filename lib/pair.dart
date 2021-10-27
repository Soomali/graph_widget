import 'point.dart';

class Pair<T, V> {
  final T first;
  final V second;

  Pair(this.first, this.second);
}

Pair<Point, Point> minMax(Iterable<Point> values) {
  var max = values.first;
  var min = values.first;
  for (var i in values) {
    if (i.value.compareTo(max.value) > 0) {
      max = i;
    }
    if (i.value.compareTo(min.value) < 0) {
      min = i;
    }
  }
  return Pair(min, max);
}
