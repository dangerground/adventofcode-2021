import 'package:adventofcode2021/util/input.dart';
import 'package:adventofcode2021/util/int_iterable.dart';

void main() {
  final input = readLinesAsString(8);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var outputs = input.map((e) => e.split(" | ")[1].split(" "));
  var count = 0;
  for (var line in outputs) {
    for (var element in line) {
      var num = -1;
      if (element.length ==
          2 /* && element.contains("c") && element.contains("f")*/) {
        // 1
        num = 1;
      }
      if (element.length ==
          4 /* && element.contains("e") && element.contains("a") && element.contains("f") && element.contains("b")*/) {
        // 4
        num = 4;
      }
      if (element.length ==
          3 /* && element.contains("a") && element.contains("c") && element.contains("f")*/) {
        // 7
        num = 7;
      }
      if (element.length == 7) {
        // 8
        num = 8;
      }
      if (num > -1) {
        num = -1;
        count++;
      }
    }
  }
  return count;
}

int part2(List<String> input) {
  var patterns =
      input.map((e) => e.split(" | ").map((e) => e.split(" ")).toList());
  var outputValues = <int>[];

  for (var pattern in patterns) {
    var inputs = pattern[0].toList();
    var outputs = pattern[1];

    var nums = {
      0: <String>{},
      1: <String>{},
      2: <String>{},
      3: <String>{},
      4: <String>{},
      5: <String>{},
      6: <String>{},
      7: <String>{},
      8: <String>{},
      9: <String>{},
    };

    var change = false;
    var nextInput = <String>[];
    do {
      nextInput = inputs.toList();
      change = false;

      for (var element in nextInput) {
        var num = determineNumber(element, nums);
        if (num > 0) {
          nums[num]!.addAll(element.chars());
          change = true;
          inputs.remove(element);
        }
      }

    } while (inputs.isNotEmpty && change);
    nums[0]!.addAll(inputs.first.chars());

    var outputValue = "";
    for (var output in outputs) {
      nums.forEach((num, wires) {
        if (wires.length == output.length) {
          if (wires.containsAll(output.chars())) {
            outputValue += "$num";
          }
        }
      });
    }
    outputValues.add(int.parse(outputValue));
  }

  return outputValues.sum();
}

int determineNumber(String element, Map<int, Set<String>> nums) {
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
    if (nums[7]!.isNotEmpty && element.containsAll(nums[7]!)) {
      return 3;
    } else if (nums[3]!.isNotEmpty && nums[9]!.isNotEmpty) {
      var possible = nums[9]!.toList();
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

    if (nums[3]!.isNotEmpty &&
        nums[4]!.isNotEmpty &&
        element.containsAll(nums[3]!) &&
        element.containsAll(nums[4]!)) {
      return 9;
    } else if (nums[8]!.isNotEmpty && nums[1]!.isNotEmpty) {
      var possible = nums[8]!.toList();
      element.chars().forEach((e) {
        possible.remove(e);
      });
      if (possible.length == 1 && nums[1]!.contains(possible.first)) {
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
