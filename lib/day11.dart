import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(11);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var map = input.map((e) => e.split("").toList()).toList();

  var height = map.length;
  var width = map[0].length;
  var steps = 100;

  printMap(map);

  var flashes = 0;
  for (var i = 0; i < steps; i++) {
    print("step ${i + 1}");
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        flashes += updateMap(map, y, x);
      }
    }
//    printMap(map);

    resetFlashes(map);
  }

  return flashes;
}

int updateMap(List<List<String>> map, int y, int x) {
  var flashes = 0;
  var wasFlashed = map[y][x].contains("[");
  var raw = map[y][x].replaceAll("[", "").replaceAll("]", "");
  var value = int.parse(raw);
  if (value == 9) {
    flashes++;
    map[y][x] = "[0]";
    for (var i = -1; i <= 1; i++) {
      for (var j = -1; j <= 1; j++) {
        if ((i == 0 && j == 0) ||
            y + i < 0 ||
            y + i >= map.length ||
            x + j < 0 ||
            x + j >= map[0].length) {
          //print("skip $i, $j -> ${y + i},${x + j}");
        } else {
          flashes += updateMap(map, y + i, x + j);
        }
      }
    }
  } else if (!wasFlashed) {
    map[y][x] = "${value + 1}";
  }

  return flashes;
}

void resetFlashes(List<List<String>> map) {
  for (var y = 0; y < 10; y++) {
    for (var x = 0; x < 10; x++) {
      map[y][x] = map[y][x].replaceAll("[", "").replaceAll("]", "");
    }
  }
}

void printMap(List<List<String>> map) {
  var result = "";
  for (var row in map) {
    for (var number in row) {
      result += number.padLeft(4);
    }
    result += "\n";
  }

  print(result);
}

int part2(List<String> input) {
  return -1;
}
