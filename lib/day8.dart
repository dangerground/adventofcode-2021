import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(8);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var outputs = input.map((e) => e.split(" | ")[1].split(" "));
  var count = 0;
  outputs.forEach((line) {
    print("---");
    line.forEach((element) {
      var num = -1;
      if (element.length == 2/* && element.contains("c") && element.contains("f")*/) {
        // 1
        num = 1;
      }
      if (element.length == 4/* && element.contains("e") && element.contains("a") && element.contains("f") && element.contains("b")*/) {
        // 4
        num = 4;
      }
      if (element.length == 3/* && element.contains("a") && element.contains("c") && element.contains("f")*/) {
        // 7
        num = 7;
      }
      if (element.length == 7) {

        // 8
        num = 8;
      }
      if (num > -1) {
        print("$element -> $num");
        num = -1;
        count++;
      }
    });
  });
  return count;
}

int part2(List<String> input) {
  return -1;
}
