import 'package:adventofcode2021/util/input.dart';
import 'package:adventofcode2021/util/window.dart';

void main() {
  final input = readLinesAsInt(1);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
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
