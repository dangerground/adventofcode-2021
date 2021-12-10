import 'dart:collection';

import 'package:adventofcode2021/day8.dart';
import 'package:collection/collection.dart';

import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(10);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

typedef Stack<E> = ListQueue<E>;

extension StackFuns<E> on Stack<E> {
  push(E el) => add(el);

  pop() => removeLast();

  Iterable<E> reversed() => toList().reversed;

  E top() => last;
}

var opener = {
  ')': '(',
  '}': '{',
  ']': '[',
  '>': '<',
};

int part1(List<String> input) {
  var syntaxErrors = <String>[];

  var points = {
    ')': 3,
    ']': 57,
    '}': 1197,
    '>': 25137,
  };

  for (var chunk in input) {
    var stackOfOpeners = Stack<String>();

    for (var bracketChar in chunk.chars()) {
      var updated = updateStack(bracketChar, stackOfOpeners);
      if (!updated) {
        syntaxErrors.add(bracketChar);
        break;
      }
    }
  }

  return syntaxErrors.map((e) => points[e]!).sum;
}

bool updateStack(String bracketChar, Stack<String> stackOfOpeners) {
  if (opener.values.contains(bracketChar)) {
    stackOfOpeners.push(bracketChar);
  } else if (stackOfOpeners.top() == opener[bracketChar]) {
    stackOfOpeners.pop();
  } else {
    return false;
  }

  return true;
}

int part2(List<String> input) {
  var points = {
    '(': 1,
    '[': 2,
    '{': 3,
    '<': 4,
  };

  var scores = <int>[];
  for (var chunk in input) {
    var stackOfOpeners = Stack<String>();

    var isValid = true;
    for (var bracketChar in chunk.chars()) {
      var updated = updateStack(bracketChar, stackOfOpeners);
      if (!updated) {
        isValid = false;
        break;
      }
    }

    if (isValid) {
      int score = 0;
      for (var bracketChar in stackOfOpeners.reversed()) {
        score *= 5;
        score += points[bracketChar]!;
      }
      scores.add(score);
    }
  }

  return scores.sorted((a, b) => a.compareTo(b))[scores.length ~/ 2];
}
