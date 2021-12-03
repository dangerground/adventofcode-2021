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
    var l = input[0].length;
    var gammaRate = "";
    var epsilonRate = "";
    for (var i = 0; i < l; i++) {
      var gammaBit = mostCommonBit(input, i);
      var epsilonBit = gammaBit == 1 ? 0 : 1;

      gammaRate = "$gammaRate$gammaBit";
      epsilonRate = "$epsilonRate$epsilonBit";
    }

    var powerConsumption = Binary(gammaRate).value * Binary(epsilonRate).value;

    return powerConsumption;
  }

  int mostCommonBit(List<String> input, bit) {
    var firstBits = input.map((e) => e[bit]);
    var firstOnes = firstBits.where((element) => element == "1");

    var gamma = 0;
    if (firstOnes.length >= firstBits.length - firstOnes.length) {
      gamma = 1;
    }
    return gamma;
  }

  int part2(List<String> input) {
    var remaining = input;
    var pos = 0;
    do {
      var common = mostCommonBit(remaining, pos);
      remaining = remainder(remaining, pos, common);

      pos++;
    } while (remaining.length > 1);

    var oxygenGeneratorRating = Binary(remaining[0]).value;

    var remaining2 = input;
    var pos2 = 0;
    do {
      var common = mostCommonBit(remaining2, pos2) == 1 ? 0 : 1;
      remaining2 = remainder(remaining2, pos2, common);

      pos2++;
    } while (remaining2.length > 1);

    var Co2ScrubberRating = Binary(remaining2[0]).value;

    return Co2ScrubberRating * oxygenGeneratorRating;
  }

  List<String> remainder(List<String> input, int pos, int common) {
    return input.where((element) => element[pos] == "$common").toList();
  }
}
