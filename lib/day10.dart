import 'package:collection/collection.dart';

import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(10);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var illegals = <String>[];

  var inverts = {
    ')': '(',
    '}': '{',
    ']': '[',
    '>': '<',
  };
  var points = {
    ')': 3,
    '}': 1197,
    ']': 57,
    '>': 25137,
  };

  for (var value in input) {
    var stack = <String>[];
    //print("---");

    for (var value1 in value.split("")) {
      if (['(', '{', '<', '['].contains(value1)) {
        //print("add: $value1");
        stack.add(value1);
      } else {
        var inv = inverts[value1]!;
        if (stack.last == inv) {
          //print("remove  $value1");
          stack.removeLast();
        } else {
          //print("found $value1 for $inv in stack: $stack");
          illegals.add(value1);
          break;
        }
      }
    }
  }

  print(illegals);

  return illegals.map((e) => points[e]!).sum;
}

int part2(List<String> input) {
  return -1;
}
