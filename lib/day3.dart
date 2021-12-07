import 'package:adventofcode2021/util/input.dart';
import 'package:quantity/number.dart';

void main() {
  final input = readLinesAsString(3);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

typedef Bit = int;

extension BitTogglee on Bit {
  int toggle() {
    if (this < 0 || this > 1) throw 'Unsupported Number';
    return this == 1 ? 0 : 1;
  }
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
