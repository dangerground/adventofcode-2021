import 'package:adventofcode2021/util/input.dart';

void main() {
  final task = Day6();

  final input = task.input();
  final solution1 = task.part1(input);
  final solution2 = task.part2(input);

  print("Solution part1: [ $solution1 ]");
  print("Solution part2: [ $solution2 ]");
}

class Day6 {
  static const int day = 6;

  List<String> input() {
    return readLinesAsString(day);
  }

  int part1(List<String> input) {

    var fishes = input[0].split(",").map((e) => int.parse(e)).toList(growable: true);

    for (int i = 0; i < 80; i++) {
      var newFishes = <int>[];

      for (int i = 0; i < fishes.length; i++) {
        var element = fishes[i];
        if (element == 0) {
          fishes[i] = 6;
          newFishes.add(8);
        } else {
          fishes[i] = element - 1;
        }
      }

      fishes.addAll(newFishes);

    }

    return fishes.length;
  }

  int part2(List<String> input) {
    return -1;
  }
}
