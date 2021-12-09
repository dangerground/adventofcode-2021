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

List<LowPoint> findLowPoints(List<List<int>> map) {
  var found = <LowPoint>[];
  var height = map.length;
  var width = map[0].length;

  // corners

  var cell = map[0][0];
  if (map[0][1] > cell && map[1][0] > cell) {
    found.add(LowPoint(0, 0, cell));
    mark(map, 0, 0);
  }
  cell = map[height - 1][width - 1];
  if (map[height - 1][width - 2] > cell && map[height - 2][width - 1] > cell) {
    found.add(LowPoint(height - 1, width - 1, cell));
  }
  cell = map[height - 1][0];
  if (map[height - 1][1] > cell && map[height - 2][0] > cell) {
    found.add(LowPoint(height - 1, 0, cell));
  }
  cell = map[0][width - 1];
  if (map[0][width - 2] > cell && map[1][width - 1] > cell) {
    found.add(LowPoint(0, width - 1, cell));
  }

  // left

  for (var y = 1; y < height - 2; y++) {
    var x = 0;
    var cell = map[y][x];
    if (map[y - 1][x] > cell && map[y][x + 1] > cell && map[y + 1][x] > cell) {
      found.add(LowPoint(y, x, cell));
    }
  }
  // right
  for (var y = 1; y < height - 2; y++) {
    var x = width - 1;
    var cell = map[y][x];
    if (map[y - 1][x] > cell && map[y][x - 1] > cell && map[y + 1][x] > cell) {
      found.add(LowPoint(y, x, cell));
    }
  }
  //top
  for (var x = 1; x < width - 2; x++) {
    var y = 0;
    var cell = map[y][x];
    if (map[y][x - 1] > cell && map[y][x + 1] > cell && map[y + 1][x] > cell) {
      found.add(LowPoint(y, x, cell));
    }
  }
  // down
  for (var x = 1; x < width - 2; x++) {
    var y = height - 1;
    var cell = map[y][x];
    if (map[y][x - 1] > cell && map[y][x + 1] > cell && map[y - 1][x] > cell) {
      found.add(LowPoint(y, x, cell));
    }
  }

  // middle
  for (var y = 1; y < height - 1; y++) {
    for (var x = 1; x < width - 1; x++) {
      var cell = map[y][x];
      if (map[y - 1][x] > cell &&
          map[y + 1][x] > cell &&
          map[y][x + 1] > cell &&
          map[y][x - 1] > cell) {
        found.add(LowPoint(y, x, cell));
      }
    }
  }
  return found;
}

void mark(List<List<int>> map, int y, int x) {
  map[y][x] = 0;
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

  var found = findLowPoints(map);
  var sums = <int>[];

  for (var lowPoint in found) {
    //print("checking lowPoint  $lowPoint");
    var totalFound = {lowPoint};
    var remainingLowPoints = {lowPoint};
    while (remainingLowPoints.isNotEmpty) {
      var checking = remainingLowPoints.first;

      var f = findNext(checking, map);
      remainingLowPoints.addAll(f);
      totalFound.addAll(f);

      remainingLowPoints.remove(checking);
    }
//    print(totalFound);
    sums.add(totalFound.length);
  }

  return sums
      .sorted((a, b) => b.compareTo(a))
      .take(3)
      .reduce((value, element) => value * element);
}

Set<LowPoint> findNext(LowPoint point, List<List<int>> map) {
  var toCheck = <LowPoint>{};

  if (point.check == Direction.vertical || point.check == Direction.all) {
    // to bottom
    for (var y = point.y + 1; y < map.length; y++) {
      var cell = map[y][point.x];
      if (cell == 9 || point.num > cell) {
        break;
      }
      toCheck.add(LowPoint(y, point.x, cell, check: Direction.horizontal));
    }

    // to top
    for (var y = point.y - 1; y >= 0; y--) {
      var cell = map[y][point.x];
      if (cell == 9 || point.num > cell) {
        break;
      }
      toCheck.add(LowPoint(y, point.x, cell, check: Direction.horizontal));
    }
  }

  if (point.check == Direction.horizontal || point.check == Direction.all) {
    // to right
    for (var x = point.x + 1; x < map[0].length; x++) {
      var cell = map[point.y][x];
      if (cell == 9 || point.num > cell) {
        break;
      }
      toCheck.add(LowPoint(point.y, x, cell, check: Direction.vertical));
    }
    // to left
    for (var x = point.x - 1; x >= 0; x--) {
      var cell = map[point.y][x];
      if (cell == 9 || point.num > cell) {
        break;
      }
      toCheck.add(LowPoint(point.y, x, cell, check: Direction.vertical));
    }
  }

  //print("new ($point): $toCheck");

  return toCheck;
}

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
