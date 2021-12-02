import 'package:adventofcode2021/util/directions.dart';
import 'package:adventofcode2021/util/input.dart';

void main() {
  final task = Day2();

  final input = task.input();
  final solution1 = task.part1(input);
  final solution2 = task.part2(input);

  print("Solution part1: [ $solution1 ]");
  print("Solution part2: [ $solution2 ]");
}

class Day2 {
  static const int day = 2;

  List<String> input() {
    return readLinesAsString(day);
  }

  int part1(List<String> input) {
    var horizontal = 0;
    var depth = 0;

    for (var value in input) {
      var instr = DirectionInstruction.parse(value);
      switch (instr.direction) {
        case Direction.forward:
          horizontal += instr.num;
          break;
        case Direction.up:
          depth -= instr.num;
          break;
        case Direction.down:
          depth += instr.num;
          break;
      }
    }

    return horizontal * depth;
  }

  int part2(List<String> input) {
    var horizontal = 0;
    var depth = 0;
    var aim = 0;

    for (var value in input) {
      var instr = DirectionInstruction.parse(value);
      switch (instr.direction) {
        case Direction.forward:
          horizontal += instr.num;
          depth += aim * instr.num;
          break;
        case Direction.up:
          aim -= instr.num;
          break;
        case Direction.down:
          aim += instr.num;
          break;
      }
    }

    return horizontal * depth;
  }
}
