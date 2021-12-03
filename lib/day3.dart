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
    if (firstOnes.length >= firstBits.length-firstOnes.length) {
      gamma = 1;
    }
    return gamma;
  }

  int part2(List<String> input) {
    var byFirstBit = input.map((e) => [e[0], e]);

    var remaining = input;
    var pos = 0;
    do {
      var common = commonBit(remaining, pos);
      remaining = remainder(remaining, pos, common);
      print(remaining);

      pos++;

    } while (remaining.length > 1 && pos <= input[0].length);

    var oxygen = binToInt(remaining[0]);

    var remaining2 = input;
    var pos2 = 0;
    do {
      var common = commonBit(remaining2, pos2) == 1 ? 0 : 1;
      remaining2 = remainder(remaining2, pos2, common);
      print(remaining2);

      pos2++;

    } while (remaining2.length > 1 && pos2 <= input[0].length);

    var scrubber = binToInt(remaining2[0]);

    return scrubber* oxygen;
  }

  int binToInt(String bin) {

    var l = bin.length;
    var result = 0;
    for (var i = 0; i < l; i++) {
      var bit = int.parse(bin[i]);

      result += bit << (l-i-1);
    }
    return result;
  }

  List<String> remainder(List<String> input, int pos, int common) {
    return input.where((element) => element[pos] == "$common").toList();
  }
}
