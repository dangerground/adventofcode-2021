import 'dart:math';

import 'package:adventofcode2021/util/input.dart';
import 'package:adventofcode2021/util/strings.dart';

void main() {
  final input = readLinesInBatches(14);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<List<String>> batches) {
  var pairs = getInitialPairs(batches);
  var pairMappings = getPairInserts(batches);

  var steps = 10;
  for (var i = 0; i < steps; i++) {
    pairs = insertMappings(pairs, pairMappings);
  }

  var corrected = countChars(pairs);

  return diffBetweenMostAndRarestChar(corrected);
}

int part2(List<List<String>> batches) {
  var pairs = getInitialPairs(batches);
  var pairMappings = getPairInserts(batches);

  var steps = 40;
  for (var i = 0; i < steps; i++) {
    pairs = insertMappings(pairs, pairMappings);
  }

  var corrected = countChars(pairs);

  return diffBetweenMostAndRarestChar(corrected);
}

int diffBetweenMostAndRarestChar(Map<String, int> corrected) {
  var most = 0;
  var uncommon = corrected.values.first;
  corrected.forEach((key, value) {
    most = max(most, value);
    uncommon = min(uncommon, value);
  });

  return (most - uncommon).toInt();
}

Map<String, int> countChars(Map<String, int> pairs) {
  var charCount = <String, int>{};
  pairs.forEach((key, value) {
    var char = key.split("").toList();
    charCount[char[0]] = (charCount[char[0]] ?? 0) + value;
    charCount[char[1]] = (charCount[char[1]] ?? 0) + value;
  });
  var corrected =
      charCount.map((key, value) => MapEntry(key, (value + 1) ~/ 2));
  return corrected;
}

Map<String, int> insertMappings(
    Map<String, int> pairs, Map<String, List<String>> pairMappings) {
  var newPairs = {...pairs};
  pairMappings.forEach((pattern, insert) {
    var value = pairs[pattern];
    if (value != null && value > 0) {
      newPairs[pattern] = (newPairs[pattern] ?? 0) - value;
      newPairs[insert[0]] = (newPairs[insert[0]] ?? 0) + value;
      newPairs[insert[1]] = (newPairs[insert[1]] ?? 0) + value;
    }
  });
  return newPairs;
}

Map<String, List<String>> getPairInserts(List<List<String>> batches) {
  var pairMappings = <String, List<String>>{};
  for (var value in batches[1].map((e) => e.split(" -> "))) {
    pairMappings[value[0]] = [
      "${value[0][0]}${value[1]}",
      "${value[1]}${value[0][1]}"
    ];
  }
  return pairMappings;
}

Map<String, int> getInitialPairs(List<List<String>> batches) {
  var pairs = <String, int>{};
  var tmpl = batches[0][0];
  for (var i = 0; i < tmpl.length - 1; i++) {
    var pair = tmpl.substring(i, i + 2);
    pairs[pair] = (pairs[pair] ?? 0) + 1;
  }
  return pairs;
}
