import 'dart:math';

import 'package:adventofcode2021/util/input.dart';
import 'package:adventofcode2021/util/strings.dart';

void main() {
  final input = readLinesInBatches(14);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<List<String>> batches) {
  var template = batches[0][0];
  var pairMappings = <String, String>{};
  for (var value in batches[1].map((e) => e.split(" -> "))) {
    pairMappings[value[0]] = value[1];
  }
  var steps = 10;
  for (var i = 0; i < steps; i++) {
    var inserts = <int, String>{};
    pairMappings.forEach((pattern, insert) {
      var lastFound = 0;
      do {
        var x = template.indexOf(pattern, lastFound);
        if (x > -1) {
          inserts[x + 1] = insert;
          //print("${x + 1} = $insert}");
        }
        lastFound = x+1;
      } while (lastFound > 0);
    });

//    print(inserts);

    var sortedInserts = inserts.keys.toList();
    sortedInserts.sort((a, b) => a.compareTo(b));

    var chars = template.chars().toList();
    sortedInserts.reversed.forEach((index) {
      //print("$index, ${inserts[index]!}");
      chars.insert(index, inserts[index]!);
    });

    template = chars.join();

    print("After step ${i+1}: ${template.length}");
  }

  var counts = <String, int>{};
  template.chars().forEach((element) {
    counts[element] = (counts[element] ?? 0) + 1;
  });

  print(counts);

  var most = 0;
  var uncommon = counts.values.first;
  counts.forEach((key, value) {
    most = max(most, value);
    uncommon = min(uncommon, value);
  });

  print("most $most * uncommon $uncommon");

  return most-uncommon;
}

int part2(List<List<String>> input) {
  return -1;
}
