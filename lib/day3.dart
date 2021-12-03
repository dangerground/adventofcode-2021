import 'package:adventofcode2021/util/input.dart';
import 'package:quantity/number.dart';

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
    var gammaRate = "";
    var epsilonRate = "";
    for (var pos = 0; pos < input.first.length; pos++) {
      var gammaBit = mostCommonBit(input, pos);
      var epsilonBit = gammaBit == 1 ? 0 : 1;

      gammaRate = "$gammaRate$gammaBit";
      epsilonRate = "$epsilonRate$epsilonBit";
    }

    var powerConsumption = Binary(gammaRate).value * Binary(epsilonRate).value;
    return powerConsumption;
  }

  int mostCommonBit(List<String> input, bit) {
    var numOfOnes =
        input.map((e) => e[bit]).where((element) => element == "1").length;

    if (numOfOnes >= input.length - numOfOnes) {
      return 1;
    }

    return 0;
  }

  int part2(List<String> input) {
    var oxygenGeneratorRating =
        reduceBy(input, (inp, pos) => mostCommonBit(inp, pos));

    var co2ScrubberRating =
        reduceBy(input, (inp, pos) => mostCommonBit(inp, pos) == 1 ? 0 : 1);

    return co2ScrubberRating * oxygenGeneratorRating;
  }

  int reduceBy(List<String> input, Function(List<String>, int) fun) {
    var remaining = input;
    for (var pos = 0; remaining.length > 1; pos++) {
      var common = fun(remaining, pos);
      remaining =
          remaining.where((element) => element[pos] == "$common").toList();
    }

    return Binary(remaining.first).value;
  }
}
