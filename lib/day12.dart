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

  print(ways);

  var routes = <List<String>>[];
  var count = countPaths(ways, 'start', routes, <String>[]);

  print(routes);

  return count;


  return routes.length;
}

int countPaths(Map<String, Set<String>> ways, String p1, List<List<String>> routes,
    List<String> visited) {


  var newVisited = List<String>.from(visited);
  if (p1.toLowerCase() == p1 && visited.contains(p1)) {
    return 0;
  } else {
    newVisited.add(p1);
  }

  int count = 0;
  if (p1 == 'end' ) {
    routes.add(newVisited);
    return 1;
  }

  for (var element in ways[p1]!) {
    //var newRoute = Set<String>.from(route);
    //newRoute.add(element);
    count += countPaths(ways, element, routes, newVisited);
  }

  return  count;
}

int part2(List<String> input) {
  return -1;
}
