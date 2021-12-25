import 'dart:math';

import 'package:adventofcode2021/util/input.dart';
import 'package:quantity/quantity.dart';

void main() {
  final input = readLinesInBatches(20);

  //print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

const defaultPixel = '.';

int part1(List<List<String>> batches) {
  return solve(batches, 2);
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

int part2(List<List<String>> batches) {
  return solve(batches, 50);
}

int solve(List<List<String>> batches, int steps) {
  var filter = batches[0][0];

  var input = LightMap(batches[1]);
  var output = LightMap([""]);

  print(input);
  print("");

  var padding = steps*3;

  var minY = input.minY - padding;
  var minX = input.minX - padding;
  var maxY = input.maxY + padding;
  var maxX = input.maxX + padding;

  for (int y = minY; y <= maxY; y++) {
    for (int x = minX; x <= maxX; x++) {
      if (input.get(x, y) == null) {
        input.set(x, y, defaultPixel);
      }
    }
  }

  for (int s = 0; s < steps; s++) {
    print("step: $s");
    output = LightMap([""]);
    for (int y = input.minY; y <= input.maxY; y++) {
      for (int x = input.minX; x <= input.maxX; x++) {
        int ref = getCorrection(input, x, y);
        output.set(x, y, filter[ref]);
      }
    }
    input = output;

  //    print(output);
  //    print("");
  }

  print(output);

  // count
  var count = 0;
  for (int x = output.minX+steps*2; x <= output.maxX-steps*2; x++) {
    for (int y = output.minY+steps*2; y <= output.maxY-steps*2; y++) {
      count += output.get(x, y) == "#" ? 1 : 0;
    }
  }

  return count;
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
