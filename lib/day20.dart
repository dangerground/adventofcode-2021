import 'dart:math';

import 'package:adventofcode2021/util/input.dart';
import 'package:quantity/quantity.dart';

void main() {
  final input = readLinesInBatches(20);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

const defaultPixel = '.';

int part1(List<List<String>> batches) {
  var filter = batches[0][0];

  var input = LightMap(batches[1]);
  var output = LightMap([""]);

  print(input);
  print("");

  var padding = 2;
  var steps = 2;
  for (int s = 0; s < steps; s++) {
    var minY = input.minY - 1;
    var minX = input.minX - 1;
    var maxY = input.maxY + 1;
    var maxX = input.maxX + 1;

    for (int y = minY; y <= maxY; y++) {
      for (int x = minX; x <= maxX; x++) {
        if (input.get(x, y) == null) {
          input.set(x, y, defaultPixel);
        }
      }
    }

    output = LightMap([""]);
    for (int y = input.minY - padding; y <= input.maxY + padding; y++) {
      for (int x = input.minX - padding; x <= input.maxX + padding; x++) {
        int ref = getCorrection(input, x, y);
        output.set(x, y, filter[ref]);
      }
    }
    input = output;

//    print(output);
//    print("");
  }

// count
  var count = 0;
  for (int x = output.minX + padding * steps;
      x <= output.maxX - padding * steps;
      x++) {
    for (int y = output.minY + padding * steps;
        y <= output.maxY - padding * steps;
        y++) {
      count += output.get(x, y) == "#" ? 1 : 0;
    }
  }

  return count;
}

int getCorrection(LightMap input, int x, int y) {
  var byte = "";
  for (var j in [-1, 0, 1]) {
    for (var i in [-1, 0, 1]) {
      var bit = input.get(x + i, y + j) == "#" ? 1 : 0;
      byte += "$bit";
    }
  }
  var binary = Binary(byte);

//  print("($x,$y) = $byte (${binary.value})");

  return binary.value;
}

int part2(List<List<String>> input) {
  return -1;
}

class LightMap {
  var m = <int, Map<int, String>>{};

  int minX = 0;
  int minY = 0;
  int maxX = 0;
  int maxY = 0;

  LightMap(List<String> lines) {
    maxY = lines.length;
    maxX = lines[0].length;

    for (var y = 0; y < maxY; y++) {
      for (var x = 0; x < maxX; x++) {
        set(x, y, lines[y][x]);
      }
    }
  }

  void set(int x, int y, String entry) {
    minX = min(x, minX);
    minY = min(y, minY);
    maxX = max(x, maxX);
    maxY = max(y, maxY);

    if (m[y] == null) {
      m[y] = <int, String>{};
      m[y]![x] = entry;
    }

    m[y]![x] = entry;
  }

  String? get(int x, int y) {
    return m[y]?[x];
  }

  @override
  String toString() {
    var result = "";
    for (var y = minY; y < maxY; y++) {
      for (var x = minX; x < maxX; x++) {
        result += get(x, y) ?? defaultPixel;
      }
      result += "\n";
    }

    return result;
  }
}
