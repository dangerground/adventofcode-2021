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

typedef Bit = int;

extension BitTogglee on Bit {
  int toggle() {
    if (this < 0 || this > 1) throw 'Unsupported Number';
    return this == 1 ? 0 : 1;
  }
}

class Day3 {
  static const int day = 3;

  List<String> input() {
    return readLinesAsString(day);
  }

  int part1(List<String> input) {
    var gamma = "";
    var epsilon = "";
    for (var pos = 0; pos < input.first.length; pos++) {
      var commonBit = mostCommonBit(input, pos);
      var uncommonBit = commonBit.toggle();

      gamma = "$gamma$commonBit";
      epsilon = "$epsilon$uncommonBit";
    }

    var powerConsumption = Binary(gamma).value * Binary(epsilon).value;
    return powerConsumption;
  }

  Bit mostCommonBit(List<String> input, bit) {
    var numOfOnes =
        input.map((e) => e[bit]).where((element) => element == "1").length;

    if (numOfOnes >= input.length - numOfOnes) {
      return 1;
    }

    return 0;
  }

  int part2(List<String> input) {
    var oxygenGenerator = reduceBy(input, (l, p) => mostCommonBit(l, p));
    var co2Scrubber = reduceBy(input, (l, p) => mostCommonBit(l, p).toggle());

    return co2Scrubber * oxygenGenerator;
  }

  int reduceBy(List<String> input, Function(List<String>, int) fun) {
    var remaining = input;
    for (var pos = 0; remaining.length > 1; pos++) {
      var common = fun(remaining, pos);
      remaining = remaining.where((e) => e[pos] == "$common").toList();
    }

    return Binary(remaining.first).value;
  }
}
