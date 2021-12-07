import 'package:adventofcode2021/util/input.dart';

import 'util/range.dart';
import 'util/int_iterable.dart';

void main() {
  final input = readLinesAsString(7);
  final solution1 = part1(input);
  final solution2 = part2(input);

  print("Solution part1: [ $solution1 ]");
  print("Solution part2: [ $solution2 ]");
}

int part1(List<String> input) {
  var positions = input[0].toIntList();
  var maxPos = positions.max();

  return range(0, maxPos).map((pos) => calcFuelSimple(positions, pos)).min();
}

int calcFuelSimple(List<int> positions, int bestPosition) {
  return positions.map((e) => (bestPosition - e).abs()).sum();
}

int part2(List<String> input) {
  var positions = input[0].toIntList();
  var maxPos = positions.max();

  return range(0, maxPos).map((pos) => calcFuelForCrabs(positions, pos)).min();
}

int calcFuelForCrabs(List<int> positions, int bestPosition) {
  return positions
      .map((e) => (bestPosition - e).abs())
      .map((e) => (e * (e + 1)) ~/ 2)
      .sum();
}
