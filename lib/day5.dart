import 'dart:math';

import 'package:adventofcode2021/util/input.dart';

import 'util/maps.dart';

void main() {
  final task = Day5();

  final input = task.input();
  final solution1 = task.part1(input);
  final solution2 = task.part2(input);

  print("Solution part1: [ $solution1 ]");
  print("Solution part2: [ $solution2 ]");
}

class Day5 {
  static const int day = 5;

  List<String> input() {
    return readLinesAsString(day);
  }

  int part1(List<String> input) {
    List<Line> lines = inputToLines(input);

    var map = AccessMap();
    for (var line in lines) {
      if (line.p1.x == line.p2.x
          ||  line.p1.y == line.p2.y) {
        drawLine(line, map);
      }
    }

    return hasMinTwo(map);
  }

  int part2(List<String> input) {
    List<Line> lines = inputToLines(input);

    var map = AccessMap();
    for (var line in lines) {
      drawLine(line, map);
    }

    return hasMinTwo(map);
  }

  void incMap(AccessMap map, int x, int y) {
    var entry = map.get(x, y) ?? 0;
    map.set(x, y, ++entry);
  }

  List<Line> inputToLines(List<String> input) {
    var lines = <Line>[];
    for (String lineSr in input) {
      var points = lineSr.split(" -> ");

      var point1 = points[0].split(",").map((e) => int.parse(e)).toList();
      var point2 = points[1].split(",").map((e) => int.parse(e)).toList();

      var line = Line(Point(point1[0], point1[1]), Point(point2[0], point2[1]));
      lines.add(line);
    }
    return lines;
  }

  void drawLine(Line line, AccessMap map) {
    var xDiff = normalizedDiff(line.p1.x, line.p2.x);
    var yDiff = normalizedDiff(line.p1.y, line.p2.y);
    var length =
        max((line.p1.x - line.p2.x).abs(), (line.p1.y - line.p2.y).abs());
    for (var i = 0; i <= length; i++) {
      var x = line.p1.x + i * xDiff;
      var y = line.p1.y + i * yDiff;
      incMap(map, x.toInt(), y.toInt());
    }
  }

  int hasMinTwo(AccessMap map) {
    var hasMinTwo = 0;
    for (var y = 0; y < map.height; y++) {
      for (var x = 0; x < map.width; x++) {
        var entry = map.get(x, y) ?? 0;
        if (entry > 1) {
          hasMinTwo++;
        }
      }
    }
    return hasMinTwo;
  }

  double normalizedDiff(var x1, var x2) {
    if (x2 - x1 == 0) return 0;
    return (x2 - x1) / (x2 - x1).abs();
  }
}

class Line {
  final Point p1;
  final Point p2;

  Line(this.p1, this.p2);

  @override
  String toString() {
    return "${p1.x},${p1.y} -> ${p2.x},${p2.y}";
  }
}
