import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(12);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var ways = <String, Set<String>>{};
  input.map((e) => e.split("-").toList()).forEach((element) {
    var p1 = element[0];
    var p2 = element[1];

    ways.putIfAbsent(p1, () => <String>{});
    ways.putIfAbsent(p2, () => <String>{});

    ways[p1]!.add(p2);
    ways[p2]!.add(p1);
  });

//  print(ways);

  var routes = <List<String>>{};
  var count = countPaths(ways, 'start', routes, <String>{});

  print(routes);

  return count;
}

int countPaths(Map<String, Set<String>> ways, String p1,
    Set<List<String>> routes, Set<String> visited) {
  var newVisited = Set<String>.from(visited);
  if (p1.toLowerCase() == p1 && visited.contains(p1)) {
    return 0;
  } else {
    newVisited.add(p1);
  }

  int count = 0;
  if (p1 == 'end') {
    routes.add(newVisited.toList());
    return 1;
  }

  for (var element in ways[p1]!) {
    //var newRoute = Set<String>.from(route);
    //newRoute.add(element);
    count += countPaths(ways, element, routes, newVisited);
  }

  return count;
}

int part2(List<String> input) {
  var ways = <String, Set<String>>{};
  input.map((e) => e.split("-").toList()).forEach((element) {
    var p1 = element[0];
    var p2 = element[1];

    ways.putIfAbsent(p1, () => <String>{});
    ways.putIfAbsent(p2, () => <String>{});

    ways[p1]!.add(p2);
    ways[p2]!.add(p1);
  });

  var routes = <List<String>>{};
  var count = countPaths2(ways, 'start', routes, [], {}, 2);

  print("count $count");
  /*routes.forEach((element) {
    print(element);
  });

   */

  return routes.length;
}

int countPaths2(
  Map<String, Set<String>> ways,
  String p1,
  Set<List<String>> routes,
  List<String> path,
  Map<String, int> visited,
  int maxVisits,
) {
  var newVisited = Map<String, int>.from(visited);

  if (smallCaveVisitedATLeastOnce(p1, newVisited)) {
    // can always only used once
    if (p1 == 'start' || p1 == 'end') {
      //print("reset $p1");
      return 0;
    }
//    print("checking $p1; $value ($maxVisits)");

    // one can be used twice
    if (maxVisits == 2 && newVisited[p1]!+1 == maxVisits) {
      //print("maxVisits $p1");
      maxVisits = 1;
    } else if (maxVisits == 1 && newVisited[p1]!+1 > maxVisits) {
      //print("reset $p1: (${newVisited[p1]!} > ${maxVisits})");
      return 0;
    }
  }

  newVisited.putIfAbsent(p1, () => 0);
  newVisited[p1] = newVisited[p1]! + 1;


  var newPath = List<String>.from(path);
  newPath.add(p1);

  int count = 0;
  if (p1 == 'end') {
//    print(newPath);
    routes.add(newPath);
    return 1;
  }

  for (var element in ways[p1]!) {
    //var newRoute = Set<String>.from(route);
    //newRoute.add(element);
    count += countPaths2(ways, element, routes, newPath, newVisited, maxVisits);
  }

  return count;
}

bool smallCaveVisitedATLeastOnce(String p1, Map<String, int> visited) {
  //print("checking $p1=${p1.toLowerCase()}: $visited");
  return p1.toLowerCase() == p1 && visited.containsKey(p1);
}
