import 'package:adventofcode2021/util/input.dart';
import 'package:adventofcode2021/util/window.dart';

void main() {
  final input = readLinesAsInt(1);
  final solution1 = part1(input);
  final solution2 = part2(input);

  print("Solution part1: [ $solution1 ]");
  print("Solution part2: [ $solution2 ]");
}

int part1(List<int> input) {
  var incs = 0;
  var lastValue = -1;
  for (var value in input) {
    if (value > lastValue) {
      incs++;
    }
    lastValue = value;
  }

  return incs - 1;
}

int part2(List<int> input) {
  var slidingWindows = slidingWindow(input, 3);
  return part1(slidingWindows);
}
