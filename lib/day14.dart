import 'dart:math';

import 'package:adventofcode2021/util/input.dart';
import 'package:adventofcode2021/util/strings.dart';
import 'package:collection/collection.dart';

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
        lastFound = x + 1;
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

    print("After step ${i + 1}: ${template.length}");
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

  return most - uncommon;
}

int part2(List<List<String>> batches) {
  var pairs = <String, int>{};
  var tmpl = batches[0][0];
  for (var i = 0; i < tmpl.length - 1; i++) {
    var pair = tmpl.substring(i, i + 2);
    pairs[pair] = (pairs[pair] ?? 0) + 1;
  }

  var pairMappings = <String, List<String>>{};
  for (var value in batches[1].map((e) => e.split(" -> "))) {
    pairMappings[value[0]] = [
      "${value[0][0]}${value[1]}",
      "${value[1]}${value[0][1]}"
    ];
  }

  print(pairs);

  var steps = 40;
  for (var i = 0; i < steps; i++) {
    var newPairs = {...pairs};
    pairMappings.forEach((pattern, insert) {
      var value = pairs[pattern];
      if (value != null && value > 0) {
        newPairs[pattern] = (newPairs[pattern] ?? 0) - value;
        newPairs[insert[0]] = (newPairs[insert[0]] ?? 0) + value;
        newPairs[insert[1]] = (newPairs[insert[1]] ?? 0) + value;
        //print("$pattern -> ${insert[0]} + ${insert[1]}");
//        print(newPairs);
      }
    });

    pairs = newPairs;

    var length = pairs.values.sum + 1;

//    print(pairs);
    print("After step ${i + 1}: ${length}");
  }


  var charCount = <String, int>{};
  pairs.forEach((key, value) {
    var char = key.split("").toList();
    charCount[char[0]] = (charCount[char[0]] ?? 0) + value;
    charCount[char[1]] = (charCount[char[1]] ?? 0) + value;
  });
  var corrected = charCount
      .map((key, value) => MapEntry(key, (value+1) ~/ 2));


  var most = 0;
  var uncommon = corrected.values.first;
    corrected.forEach((key, value) {
        print("char $key = $value");
    most = max(most, value);
    uncommon = min(uncommon, value);
  });

  print("most $most * uncommon $uncommon");

  return (most - uncommon).toInt();
}
