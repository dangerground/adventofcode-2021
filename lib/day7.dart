import 'package:adventofcode2021/util/input.dart';

import 'util/range.dart';
import 'util/int_iterable.dart';

void main() {
  final task = Day7();

  final input = task.input();
  final solution1 = task.part1(input);
  final solution2 = task.part2(input);

  print("Solution part1: [ $solution1 ]");
  print("Solution part2: [ $solution2 ]");
}

class Day7 {
  static const int day = 7;

  List<String> input() {
    return readLinesAsString(day);
  }

  int part1(List<String> input) {
    var positions = input[0].split(",").map((e) => int.parse(e)).toList();
    var maxPos = positions.max();

    return range(0, maxPos)
        .map((pos) => calcFuelSimple(positions, pos))
        .min();
  }

  int calcFuelSimple(List<int> positions, int bestPosition) {
    return positions
        .map((e) => (bestPosition - e).abs())
        .sum();
  }

  int part2(List<String> input) {
    var positions = input[0].split(",").map((e) => int.parse(e)).toList();
    var maxPos = positions.max();

    return range(0, maxPos)
        .map((pos) => calcFuelForCrabs(positions, pos))
        .min();
  }

  int calcFuelForCrabs(List<int> positions, int bestPosition) {
    return positions
        .map((e) => (bestPosition - e).abs())
        .map((e) => (e * (e + 1)) ~/ 2)
        .sum();
  }
}
