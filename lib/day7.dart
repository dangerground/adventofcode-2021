import 'package:adventofcode2021/util/input.dart';

void main() {
  final task = Day7();

  final input = task.input();
  final solution1 = task.part1(input);
  final solution2 = task.part2(input);

  print("Solution part1: [ $solution1 ]");
  print("Solution part2: [ $solution2 ]");
}

class Day7 {
  static const int day = 7;

  List<String> input() {
    return readLinesAsString(day);
  }

  int part1(List<String> input) {
    var positions = input[0].split(",").map((e) => int.parse(e)).toList();

    var bestPosition = 0;
    var bestFuelRequired = -1;

    var averagePosition = positions.reduce((acc, v) => acc +  v) ~/ positions.length;

    bestPosition = averagePosition;
    var fuelRequired = -1;
    do {
      fuelRequired = positions.map((e) => (bestPosition - e).abs()).reduce((value, element) => value + element);

      print(fuelRequired);

      if (fuelRequired < bestFuelRequired || bestFuelRequired == -1) {
        bestFuelRequired = fuelRequired;
      } else {
        break;
      }

      bestPosition++;
    } while (true);


    bestPosition = averagePosition - 1;
    do {
      fuelRequired = positions.map((e) => (bestPosition - e).abs()).reduce((value, element) => value + element);

      if (fuelRequired < bestFuelRequired || bestFuelRequired == -1) {
        bestFuelRequired = fuelRequired;
      } else {
        break;
      }

      bestPosition--;
    } while (true);

    return bestFuelRequired;
  }

  int part2(List<String> input) {
    return -1;
  }
}
