import 'package:adventofcode2021/util/input.dart';

void main() {
  final task = Day3();

  final input = task.input();
  final solution1 = task.part1(input);
  final solution2 = task.part2(input);

  print("Solution part1: [ $solution1 ]");
  print("Solution part2: [ $solution2 ]");
}

class Day3 {
  static const int day = 3;

  List<String> input() {
    return readLinesAsString(day);
  }

  int part1(List<String> input) {

    var l = input[0].length;
    var gamma = 0;
    var epsilon = 0;
    for (var i = 0; i < l; i++) {
      var bit = commonBit(input, i);

      gamma += bit << (l-i-1);
      epsilon += (bit == 1 ? 0 : 1) << (l-i-1);
    }

    return gamma * epsilon;
  }

  int commonBit(List<String> input, bit) {

    var firstBits = input.map((e) => e[bit]);
    var firstOnes = firstBits.where((element) => element == "1");

    var gamma = 0;
    if (firstOnes.length > firstBits.length-firstOnes.length) {
      gamma = 1;
    }
    return gamma;
  }

  int part2(List<String> input) {
    return -1;
  }
}
