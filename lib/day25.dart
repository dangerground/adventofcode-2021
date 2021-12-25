import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(25);

  print("Solution part1: [ ${part1(input)} ]");
//  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var map = CucumberMap(input);

  var moved = false;
  var steps = 0;
  do {
    steps++;
    moved = false;
    moved |= moveEast(map);
    moved |= moveSouth(map);
  } while (moved);

  return steps;
}

bool moveEast(CucumberMap map) {
  var moved = false;

  var copy = CucumberMap.clone(map);

  for (var y = 0; y < map.height; y++) {
    for (var x = 0; x < map.width; x++) {
      var nx = (x + 1) % map.width;
      if (copy.m[y][x] == ">" && copy.m[y][nx] == ".") {
        map.m[y][x] = ".";
        map.m[y][nx] = ">";
        moved = true;
      }
    }
  }

  return moved;
}

bool moveSouth(CucumberMap map) {
  var moved = false;
  var copy = CucumberMap.clone(map);

  for (var y = 0; y < map.height; y++) {
    var ny = (y + 1 < map.height) ? y + 1 : 0;
    for (var x = 0; x < map.width; x++) {
      if (copy.m[y][x] == "v" && copy.m[ny][x] == ".") {
        map.m[y][x] = ".";
        map.m[ny][x] = "v";
        moved = true;
      }
    }
  }

  return moved;
}

int part2(List<String> input) {
  return -1;
}

class CucumberMap {
  late final List<List<String>> m;

  late int height;
  late int width;

  CucumberMap(List<String> input) {
    m = input.map((e) => e.split("").toList()).toList();
    height = m.length;
    width = m[0].length;
  }

  CucumberMap.clone(CucumberMap other) {
    m = List.generate(other.m.length, (index) => List.unmodifiable(other.m[index]));
    height = m.length;
    width = m[0].length;
  }

  @override
  String toString() {
    var result = "";
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        result += m[y][x];
      }
      result += "\n";
    }

    return result;
  }
}
