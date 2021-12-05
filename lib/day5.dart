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
      if (line.p1.x == line.p2.x) {
        var x = line.p1.x;
        var minY = min(line.p1.y, line.p2.y);
        var maxY = max(line.p1.y, line.p2.y);
        for (var y = minY; y <= maxY; y++) {
          incMap(map, x, y);
        }
      } else if (line.p1.y == line.p2.y) {
        var minX = min(line.p1.x, line.p2.x);
        var maxX = max(line.p1.x, line.p2.x);
        var y = line.p1.y;
        for (var x = minX; x <= maxX; x++) {
          incMap(map, x, y);
        }
      } else {
        // ignore for part1
      }
    }

//    print(map);

    print("check");

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

  int part2(List<String> input) {
    List<Line> lines = inputToLines(input);

    var map = AccessMap();
    for (var line in lines) {
      if (line.p1.x == line.p2.x) {
        var x = line.p1.x;
        var minY = min(line.p1.y, line.p2.y);
        var maxY = max(line.p1.y, line.p2.y);
        for (var y = minY; y <= maxY; y++) {
          incMap(map, x, y);
        }
      } else if (line.p1.y == line.p2.y) {
        var minX = min(line.p1.x, line.p2.x);
        var maxX = max(line.p1.x, line.p2.x);
        var y = line.p1.y;
        for (var x = minX; x <= maxX; x++) {
          incMap(map, x, y);
        }
      } else {
        var xDiff =(line.p2.x - line.p1.x) / (line.p2.x - line.p1.x).abs();
        var yDiff =(line.p2.y - line.p1.y) / (line.p2.y - line.p1.y).abs();
        var length = (line.p1.x - line.p2.x).abs();
        for (var i = 0; i <= length; i++) {

          var x = line.p1.x + i*xDiff;
          var y = line.p1.y + i*yDiff;
          incMap(map, x.toInt(), y.toInt());
        }
        // ignore for part1
        print("ignore $line");
      }
    }
//    print(map);

    print("check");

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
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);
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
