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
  Map<String, Set<String>> ways,
  String p1,
  Map<String, int> visited,
  int maxVisits,
) {
  var newVisited = Map<String, int>.from(visited);

  if (smallCaveVisitedATLeastOnce(p1, newVisited)) {
    // can always only used once
    if (p1 == 'start' || p1 == 'end') {
      return 0;
    }

    // one can be used twice
    if (maxVisits == 2 && newVisited[p1]! + 1 == maxVisits) {
      maxVisits = 1;
    } else if (maxVisits == 1 && newVisited[p1]! + 1 > maxVisits) {
      return 0;
    }
  }

  newVisited.putIfAbsent(p1, () => 0);
  newVisited[p1] = newVisited[p1]! + 1;

  int count = 0;
  if (p1 == 'end') {
    return 1;
  }

  for (var element in ways[p1]!) {
    count += countPaths(ways, element, newVisited, maxVisits);
  }

  return count;
}

bool smallCaveVisitedATLeastOnce(String p1, Map<String, int> visited) {
  return p1.toLowerCase() == p1 && visited.containsKey(p1);
}
