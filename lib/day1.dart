import 'package:adventofcode2021/utils/input_util.dart';

class Day1 {
  static const int day = 1;

  int part1solution() {
    final input = InputUtil.readLinesAsInt(day);
    return part1calc(input);
  }

  int part2solution() {
    final input = InputUtil.readLinesAsInt(day);
    return part2calc(input);
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

  int part2calc(List<int> input) {
    final threesome = List<int>.filled(input.length, 0, growable: true);
    for (int i = 2; i < input.length; i++) {
      threesome[i] += input[i - 2];
      threesome[i] += input[i - 1];
      threesome[i] += input[i];
    }
    threesome.removeRange(0, 2);

    print(threesome);

    return part1calc(threesome);
  }
}
