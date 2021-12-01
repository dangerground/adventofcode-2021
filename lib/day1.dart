import 'package:adventofcode2021/utils/input_util.dart';

class Day1 {
  static const int day = 1;

  int part1solution() {
    final input = InputUtil.readLinesAsInt(day);
    return part1calc(input);
  }

  int part1calc(List<int> input) {
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
}
