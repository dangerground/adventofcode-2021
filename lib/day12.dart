import 'package:collection/collection.dart';

import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(12);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  Map<String, Set<String>> ways = directionalEdges(input);

  return countPaths(ways, 'start', {}, 1);
}

Map<String, Set<String>> directionalEdges(List<String> input) {
  var ways = <String, Set<String>>{};
  input.map((e) => e.split("-").toList()).forEach((element) {
    var p1 = element[0];
    var p2 = element[1];

    ways.putIfAbsent(p1, () => <String>{});
    ways.putIfAbsent(p2, () => <String>{});

    ways[p1]!.add(p2);
    ways[p2]!.add(p1);
  });
  return ways;
}

int part2(List<String> input) {
  Map<String, Set<String>> ways = directionalEdges(input);

  return countPaths(ways, 'start', {}, 2);
}

int countPaths(
  Map<String, Set<String>> edges,
  String knot,
  Map<String, int> visited,
  int maxVisits,
) {
  if (knot == 'end') {
    return 1;
  }

  var newVisited = Map<String, int>.from(visited);
  newVisited.putIfAbsent(knot, () => 0);
  newVisited[knot] = newVisited[knot]! + 1;

  if (smallCaveVisitedATLeastOnce(knot, visited)) {
    // can always only used once
    if (knot == 'start') {
      return 0;
    } else if (newVisited[knot]! == maxVisits) {
      maxVisits = 1;
    } else if (newVisited[knot]! > maxVisits) {
      return 0;
    }
  }

  return edges[knot]!
      .map((e) => countPaths(edges, e, newVisited, maxVisits))
      .sum;
}

bool smallCaveVisitedATLeastOnce(String p1, Map<String, int> visited) {
  return p1.toLowerCase() == p1 && visited.containsKey(p1);
}
