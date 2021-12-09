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

  List<int> found = findLowPoints(map);

  printMap(map);

  return found.map((e) => e + 1).toList().sum;
}

List<int> findLowPoints(List<List<int>> map) {
  
  var found = <int>[];
  var height = map.length;
  var width = map[0].length;
  
  // corners
  
  var cell = map[0][0];
  if (map[0][1] > cell && map[1][0] > cell) {
    found.add(cell);
    mark(map, 0, 0);
  }
  cell = map[height - 1][width - 1];
  if (map[height - 1][width - 2] > cell && map[height - 2][width - 1] > cell) {
    found.add(cell);
  }
  cell = map[height - 1][0];
  if (map[height - 1][1] > cell && map[height - 2][0] > cell) {
    found.add(cell);
  }
  cell = map[0][width - 1];
  if (map[0][width - 2] > cell && map[1][width - 1] > cell) {
    found.add(cell);
  }
  
  // left
  
  for (var y = 1; y < height - 2; y++) {
    var x = 0;
    var cell = map[y][x];
    if (map[y - 1][x] > cell && map[y][x + 1] > cell && map[y + 1][x] > cell) {
      found.add(cell);
    }
  }
  // right
  for (var y = 1; y < height - 2; y++) {
    var x = width - 1;
    var cell = map[y][x];
    if (map[y - 1][x] > cell && map[y][x - 1] > cell && map[y + 1][x] > cell) {
      found.add(cell);
    }
  }
  //top
  for (var x = 1; x < width - 2; x++) {
    var y = 0;
    var cell = map[y][x];
    if (map[y][x - 1] > cell && map[y][x + 1] > cell && map[y+1][x] > cell) {
      found.add(cell);
    }
  }
  // down
  for (var x = 1; x < width - 2; x++) {
    var y = height-1;
    var cell = map[y][x];
    if (map[y][x - 1] > cell && map[y][x + 1] > cell && map[y-1][x] > cell) {
      found.add(cell);
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
        found.add(cell);
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
    result+="\n";
  }

  print(result);
}

int part2(List<String> input) {
  return -1;
}
