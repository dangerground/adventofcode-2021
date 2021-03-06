import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(6);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var fishes = input[0].toIntList();

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
  var fishes = input[0].toIntList();

  var incMap = {
    0: fishes.where((element) => element == 0).length,
    1: fishes.where((element) => element == 1).length,
    2: fishes.where((element) => element == 2).length,
    3: fishes.where((element) => element == 3).length,
    4: fishes.where((element) => element == 4).length,
    5: fishes.where((element) => element == 5).length,
    6: fishes.where((element) => element == 6).length,
    7: fishes.where((element) => element == 7).length,
    8: fishes.where((element) => element == 8).length,
  };

  //print(incMap);
  for (int i = 0; i < 256; i++) {
    var newMap = {
      0: incMap[1]!,
      1: incMap[2]!,
      2: incMap[3]!,
      3: incMap[4]!,
      4: incMap[5]!,
      5: incMap[6]!,
      6: (incMap[7]! + incMap[0]!),
      7: incMap[8]!,
      8: incMap[0]!,
    };

    incMap = newMap;

//      print(incMap);
  }

  return incMap.entries
      .map((e) => e.value)
      .reduce((value, element) => value + element);
}
