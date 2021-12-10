import 'package:adventofcode2021/day8.dart';
import 'package:collection/collection.dart';

import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(10);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

var beginner = {
  ')': '(',
  '}': '{',
  ']': '[',
  '>': '<',
};
var closer = {
  '(': ')',
  '{': '}',
  '[': ']',
  '<': '>',
};

int part1(List<String> input) {
  var illegals = <String>[];

  var points = {
    ')': 3,
    ']': 57,
    '}': 1197,
    '>': 25137,
  };

  for (var value in input) {
    var stack = <String>[];
    //print("---");

    for (var value1 in value.chars()) {
      if (beginner.values.contains(value1)) {
        //print("add: $value1");
        stack.add(value1);
      } else {
        var inv = beginner[value1]!;
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
  var points = {
    ')': 1,
    ']': 2,
    '}': 3,
    '>': 4,
  };

  var scores = <int>[];
  for (var value in input) {
    var stack = <String>[];
    //print("---");

    var isValid = true;
    for (var value1 in value.chars()) {
      if (beginner.values.contains(value1)) {
        //print("add: $value1");
        stack.add(value1);
      } else {
        var inv = beginner[value1]!;
        if (stack.last == inv) {
          //print("remove  $value1");
          stack.removeLast();
        } else {
          isValid = false;
          //print("found $value1 for $inv in stack: $stack");
          break;
        }
      }
    }
    if (isValid) {
      int score = 0;
      for (var v2 in stack.reversed) {
        score *= 5;
        score += points[closer[v2]!]!;
      }
      print(score);
      scores.add(score);
    }
  }

  return scores.sorted((a, b) => a.compareTo(b))[scores.length ~/ 2];
}
