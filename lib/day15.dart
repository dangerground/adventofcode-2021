import 'dart:math';

import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesAsString(15);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var map = LocalMap(input);

  var nodes = createNodes(map);
  addEdgesToNodes(nodes, map);

  calcDistances(nodes);

  return nodes
      .firstWhere((e) => e == Node(map.width - 1, map.height - 1))
      .distance;
}

void addEdgesToNodes(Set<Node> nodes, LocalMap map) {
  var start = DateTime.now().microsecondsSinceEpoch;

  // assign edges
  nodes.forEach((e) {
    var edges = <Node, int>{};
    if (e.x + 1 < map.width)
      edges[nodes.firstWhere((element) => element == Node(e.x + 1, e.y))] =
          map.m[e.x + 1][e.y];
    //if (e.x - 1 >= 0) edges[nodes.firstWhere((element) => element == Node(e.x - 1, e.y))] = map.m[e.x - 1][e.y];
    if (e.y + 1 < map.height)
      edges[nodes.firstWhere((element) => element == Node(e.x, e.y + 1))] =
          map.m[e.x][e.y + 1];
    //if (e.y - 1 >= 0) edges[nodes.firstWhere((element) => element == Node(e.x, e.y - 1))] = map.m[e.x][e.y - 1];
    e.edges = edges;
  });
  print("addEdges: ${DateTime.now().microsecondsSinceEpoch - start}µs");
}

Set<Node> createNodes(LocalMap map) {
  var start = DateTime.now().microsecondsSinceEpoch;

  var nodes = <Node>{};
  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      nodes.add(Node(x, y));
    }
  }

  print("createNodes: ${DateTime.now().microsecondsSinceEpoch - start}µs");
  return nodes;
}

void calcDistances(Set<Node> nodes) {

  var settled = <Node>{};

  var unsettled = {nodes.first};
  unsettled.first.distance = 0;

  var start = DateTime.now().microsecondsSinceEpoch;
  do {
    Node pick = findShortest(unsettled);
    for (var element in pick.edges.entries) {
      if (settled.contains(element.key)) {
        continue;
      }

      unsettled.add(nodes.firstWhere((e) => e == element.key));

      if (pick.distance + element.value < element.key.distance) {
        element.key.distance = pick.distance + element.value;
      }
    }

    unsettled.remove(pick);
    settled.add(pick);
    //if (Random().nextInt(1000) == 0)

  } while (unsettled.isNotEmpty);
  print(
      "loop: ${DateTime.now().microsecondsSinceEpoch - start}µs - ${settled.length} - ${unsettled.length} ;: pick");
}

Node findShortest(Set<Node> unsettled) {
  var distance = unsettled.first.distance;
  Node shortNode = unsettled.first;
  for (var element in unsettled) {
    if (element.distance < distance) {
      distance = element.distance;
      shortNode = element;
    }
  }

  return shortNode;
}

int part2(List<String> input) {
  return -1;
}

class LocalMap {
  late final List<List<int>> m;

  late int height;
  late int width;

  LocalMap(List<String> input) {
    m = input
        .map((e) => e.split("").map((e) => int.parse(e)).toList())
        .toList();
    height = m.length;
    width = m[0].length;
  }
}

class Node {
  int x;
  int y;

  Map<Node, int> edges;

  int distance = 0x7fffffffffffffff;
  Node? previous;

  Node(this.x, this.y, {this.edges = const {}});

  @override
  int get hashCode => 13 * x + 37 * y;

  @override
  bool operator ==(Object other) {
    return (other is Node) && other.y == y && other.x == x;
  }

  @override
  String toString() {
    return "($x $y)[${distance}]";
  }
}
