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
    var x = 0;
    var y = 0;
    for (var value in input) {
      if (value.startsWith("forward")) {
        var num = value.substring(8);
        x += int.parse(num);
      } else if (value.startsWith("down")) {
        var num = value.substring(5);
        y += int.parse(num);
      } else if (value.startsWith("up")) {
        var num = value.substring(3);
        y -= int.parse(num);
      }
    }
    return x*y;
  }

  int part2(List<String> input) {
    var x = 0;
    var y = 0;
    var aim = 0;
    for (var value in input) {
      if (value.startsWith("forward")) {
        var num = value.substring(8);
        x += int.parse(num);
        y += aim * int.parse(num);
      } else if (value.startsWith("down")) {
        var num = value.substring(5);
        aim += int.parse(num);
      } else if (value.startsWith("up")) {
        var num = value.substring(3);
        aim -= int.parse(num);
      }
    }
    return x*y;
  }
}
