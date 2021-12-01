import 'package:adventofcode2021/util/input.dart';
import 'package:adventofcode2021/util/window.dart';

void main() {
  final task = Day1();

  final input = task.input();
  final solution1 = task.part1(input);
  final solution2 = task.part2(input);

  print("Solution part1: [ $solution1 ]");
  print("Solution part2: [ $solution2 ]");
}

class Day1 {
  static const int day = 1;

  List<int> input() {
    return readLinesAsInt(day);
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
}
