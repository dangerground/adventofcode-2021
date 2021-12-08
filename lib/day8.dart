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

    List<Set<String>> nums = getNumberMappings(inputs);
    outputValues.add(patternsToOutputValue(outputs, nums));
  }

  return outputValues.sum;
}

List<Set<String>> getNumberMappings(List<String> inputs) {
  var nums = Iterable.generate(10).map((e) => <String>{}).toList();

  var change = false;
  var nextInput = <String>[];
  do {
    nextInput = inputs.toList();
    change = false;

    for (var element in nextInput) {
      var num = determineNumber(element, nums);
      if (num > 0) {
        nums[num] = element.chars().toSet();
        change = true;
        inputs.remove(element);
      }
    }
  } while (inputs.isNotEmpty && change);
  nums[0].addAll(inputs.first.chars());
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
  } else if (element.length == 5) {
    // 2 | 3 | 5
    if (nums[7].isNotEmpty && element.containsAll(nums[7])) {
      return 3;
    } else if (nums[3].isNotEmpty && nums[9].isNotEmpty) {
      var possible = nums[9].toList();
      element.chars().forEach((e) {
        possible.remove(e);
      });

      if (possible.length == 1) {
        return 5;
      } else {
        return 2;
      }
    }
  } else if (element.length == 6) {
    // 0 | 6 | 9

    if (nums[3].isNotEmpty &&
        nums[4].isNotEmpty &&
        element.containsAll(nums[3]) &&
        element.containsAll(nums[4])) {
      return 9;
    } else if (nums[8].isNotEmpty && nums[1].isNotEmpty) {
      var possible = nums[8].toList();
      element.chars().forEach((e) {
        possible.remove(e);
      });
      if (possible.length == 1 && nums[1].contains(possible.first)) {
        return 6;
      } else {
        return 0;
      }
    }
  }

  return -1;
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
