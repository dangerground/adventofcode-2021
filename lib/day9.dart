import 'dart:math';

import 'package:collection/collection.dart';

import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(9);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var map =
      input.map((e) => e.split("").map((e) => int.parse(e)).toList()).toList();

  return findLowPoints(map).map((e) => e.num + 1).toList().sum;
}

Set<LowPoint> findLowPoints(List<List<int>> map) {
  var lowPoints = <LowPoint>{};
  var height = map.length;
  var width = map[0].length;

  // middle
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      var cell = map[y][x];

      if ((y == 0 || map[y - 1][x] > cell) &&
          (y == height - 1 || map[y + 1][x] > cell) &&
          (x == width - 1 || map[y][x + 1] > cell) &&
          (x == 0 || map[y][x - 1] > cell)) {
        lowPoints.add(LowPoint(y, x, cell));
      }
    }
  }

  return lowPoints;
}

void printMap(map) {
  var result = "";
  var height = map.length;
  var width = map[0].length;
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      var cell = map[y][x];
      result += "$cell";
    }
    result += "\n";
  }

  print(result);
}

int part2(List<String> input) {
  var map =
      input.map((e) => e.split("").map((e) => int.parse(e)).toList()).toList();

  var lowPoints = findLowPoints(map);
  var basinSizes = <int>[];

  for (var lowPoint in lowPoints) {
    var basin = {lowPoint};
    var checkIfBasin = {lowPoint};
    while (checkIfBasin.isNotEmpty) {
      var current = checkIfBasin.first;

      var newPoints = findNext(current, map);
      checkIfBasin.addAll(newPoints);
      basin.addAll(newPoints);

      checkIfBasin.remove(current);
    }
//    print(totalFound);
    basinSizes.add(basin.length);
  }

  return basinSizes
      .sorted((a, b) => b.compareTo(a))
      .take(3)
      .reduce((value, element) => value * element);
}

Set<LowPoint> findNext(LowPoint point, List<List<int>> map) {
  var newPoints = <LowPoint>{};

  if (point.check == Direction.vertical || point.check == Direction.all) {
    // to bottom
    for (var y = point.y + 1; y < map.length; y++) {
      var cell = map[y][point.x];
      if (isNotInBasin(cell, point)) {
        break;
      }
      newPoints.add(LowPoint(y, point.x, cell, check: Direction.horizontal));
    }

    // to top
    for (var y = point.y - 1; y >= 0; y--) {
      var cell = map[y][point.x];
      if (isNotInBasin(cell, point)) {
        break;
      }
      newPoints.add(LowPoint(y, point.x, cell, check: Direction.horizontal));
    }
  }

  if (point.check == Direction.horizontal || point.check == Direction.all) {
    // to right
    for (var x = point.x + 1; x < map[0].length; x++) {
      var cell = map[point.y][x];
      if (isNotInBasin(cell, point)) {
        break;
      }
      newPoints.add(LowPoint(point.y, x, cell, check: Direction.vertical));
    }
    // to left
    for (var x = point.x - 1; x >= 0; x--) {
      var cell = map[point.y][x];
      if (isNotInBasin(cell, point)) {
        break;
      }
      newPoints.add(LowPoint(point.y, x, cell, check: Direction.vertical));
    }
  }

  //print("new ($point): $toCheck");

  return newPoints;
}

bool isNotInBasin(int cell, LowPoint point) => cell == 9 || point.num > cell;

class LowPoint extends Point<int> {
  final int num;
  final Direction check;

  LowPoint(int y, int x, this.num, {this.check = Direction.all}) : super(x, y);

  @override
  String toString() {
    return "($y, $x) =  $num";
  }
}

enum Direction { all, horizontal, vertical, ignore }
