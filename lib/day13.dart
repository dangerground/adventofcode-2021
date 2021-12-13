import 'dart:math';

import 'package:adventofcode2021/util/input.dart';
import 'package:adventofcode2021/util/maps.dart';

void main() {
  final input = readLinesInBatches(13);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<List<String>> batches) {
  var points = batches[0].map(toPoint).toSet();

  batches[1].take(1).forEach((element) {
    points = foldBy(element, points);
  });

  return points.length;
}

Point<int> toPoint(String e) {
  var p = e.split(",");
  return Point<int>(int.parse(p[0]), int.parse(p[1]));
}

int part2(List<List<String>> batches) {
  var points = batches[0].map(toPoint).toSet();

  // fold
  batches[1].forEach((element) {
    points = foldBy(element, points);
  });

  // print
  var map = AccessMap();
  points.forEach((element) {
    map.set(element.x, element.y, 1);
  });
  print(map);

  return 0;
}

Set<Point<int>> foldBy(String element, Set<Point<int>> points) {
  var testY = element.split("fold along y=");
  var testX = element.split("fold along x=");
  if (testX.length == 2) {
    return foldAtX(points, int.parse(testX[1]));
  } else {
    return foldAtY(points, int.parse(testY[1]));
  }
}

Set<Point<int>> foldAtY(Set<Point<int>> points, int foldAt) {
  return points
      .map((p) => (p.y < foldAt) ? p : Point(p.x, 2 * foldAt - p.y))
      .toSet();
}

Set<Point<int>> foldAtX(Set<Point<int>> points, int foldAt) {
  return points
      .map((p) => (p.x < foldAt) ? p : Point(2 * foldAt - p.x, p.y))
      .toSet();
}
