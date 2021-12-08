import 'package:collection/collection.dart';

import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(8);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var outputs = input.map((e) => e.split(" | ")[1].split(" "));
  return outputs.map((line) => line.where(isUnique).length).sum;
}

bool isUnique(String element) => [2, 3, 4, 7].contains(element.length);

int part2(List<String> input) {
  var patterns =
      input.map((e) => e.split(" | ").map((e) => e.split(" ")).toList());
  var outputValues = <int>[];

  for (var pattern in patterns) {
    var inputs = pattern[0].toList();
    var outputs = pattern[1];

    List<Set<String>> numbers = getNumberMappings(inputs);
    outputValues.add(patternsToOutputValue(outputs, numbers));
  }

  return outputValues.sum;
}

List<Set<String>> getNumberMappings(List<String> remainingSignals) {
  var nums = Iterable.generate(10).map((e) => <String>{}).toList();

  var change = false;
  var nextInput = <String>[];
  do {
    nextInput = remainingSignals.toList();
    change = false;

    for (var signal in nextInput) {
      var num = determineNumber(signal, nums);
      if (num > 0) {
        nums[num] = signal.chars().toSet();
        change = true;
        remainingSignals.remove(signal);
      }
    }
  } while (remainingSignals.isNotEmpty && change);
  nums[0].addAll(remainingSignals.first.chars());
  return nums;
}

int patternsToOutputValue(List<String> outputs, List<Set<String>> nums) {
  var outputValue = "";
  for (var output in outputs) {
    for (var num = 0; num < 10; num++) {
      var wires = nums[num].sorted((a, b) => a.compareTo(b));
      var check = output.chars().toSet().sorted((a, b) => a.compareTo(b));
      if (IterableEquality().equals(wires, check)) {
        outputValue += "$num";
        break;
      }
    }
  }
  return int.parse(outputValue);
}

int determineNumber(String element, List<Set<String>> nums) {
  if (element.length == 2) {
    return 1;
  } else if (element.length == 3) {
    return 7;
  } else if (element.length == 4) {
    return 4;
  } else if (element.length == 7) {
    return 8;
  } else if (isSeven(nums, element)) {
    return 3;
  } else if (isTwoOrFive(nums, element)) {
    if (isFive(nums, element)) {
      return 5;
    } else {
      return 2;
    }
  } else if (isNine(nums, element)) {
    return 9;
  } else if (isSixOrZero(nums)) {
    if (isSix(nums, element)) {
      return 6;
    } else {
      return 0;
    }
  }

  return -1;
}

bool isSix(List<Set<String>> nums, String element) {
  var possible = nums[8].toList();
  element.chars().forEach((e) {
    possible.remove(e);
  });
  return possible.length == 1 && nums[1].contains(possible.first);
}

bool isSixOrZero(List<Set<String>> nums) {
  return nums[8].isNotEmpty && nums[1].isNotEmpty;
}

bool isFive(List<Set<String>> nums, String element) {
  var possible = nums[9].toList();
  element.chars().forEach((e) {
    possible.remove(e);
  });

  return possible.length == 1;
}

bool isTwoOrFive(List<Set<String>> nums, String element) {
  if (element.length != 5) {
    return false;
  }

  return nums[3].isNotEmpty && nums[9].isNotEmpty;
}

bool isSeven(List<Set<String>> nums, String element) {
  if (element.length != 5) {
    return false;
  }

  return nums[7].isNotEmpty && element.containsAll(nums[7]);
}

bool isNine(List<Set<String>> nums, String element) {
  if (element.length != 6) {
    return false;
  }

  return nums[3].isNotEmpty &&
      nums[4].isNotEmpty &&
      element.containsAll(nums[3]) &&
      element.containsAll(nums[4]);
}

extension StringContainsAll on String {
  bool containsAll(Iterable<String> contain) {
    for (var value in contain) {
      if (!contains(value)) {
        return false;
      }
    }

    return true;
  }

  Iterable<String> chars() {
    var res = <String>[];
    for (var i = 0; i < length; i++) {
      res.add(this[i]);
    }

    return res;
  }
}
