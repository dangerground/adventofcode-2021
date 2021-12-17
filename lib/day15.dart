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

  calcDistances(nodes);

  return nodes
      .firstWhere((e) => e == Node(map.width - 1, map.height - 1))
      .distance;
}

Set<Node> createNodes(LocalMap map) {
  var start = DateTime.now().microsecondsSinceEpoch;

  var nodes = <Node>{};
  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      var edges = <Edge>{};
      if (x + 1 < map.width) edges.add(Edge(x + 1, y, map.m[x + 1][y]));
      if (y + 1 < map.height) edges.add(Edge(x, y+1, map.m[x][y+1]));

      nodes.add(Node(x, y, edges: edges));
      if (Random.secure().nextInt(1000) == 0) print("nodes ${nodes.length}");
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
    for (var element in pick.edges) {
      var node = Node(element.x, element.y);
      if (settled.contains(node)) {
        continue;
      }

      node = nodes.firstWhere((e) => e == node);
      unsettled.add(node);

      if (pick.distance + element.weight < node.distance) {
        node.distance = pick.distance + element.weight;
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
  var start = DateTime.now().microsecondsSinceEpoch;

  // extend columns
  var newput = <List<int>>[];
  for (var value in input) {
    var line = <int>[];
    var numbers = value.split("").map((e) => int.parse(e));
    for (var i = 0; i < 5; i++) {
      line.addAll(numbers.map((e) => e + i <= 9 ? e + i : (e + i) % 9));
    }
    newput.add(line);
  }

  // rows
  var newput2 = <String>[];
  for (var i = 0; i < 5; i++) {
    for (var value in newput) {
      var line = value.map((e) => e + i <= 9 ? e + i : (e + i) % 9).join();
      newput2.add(line);
    }
  }

//  print(newput2);
  var map = LocalMap(newput2);
  print("parsemap: ${DateTime.now().microsecondsSinceEpoch - start}µs");

  var nodes = createNodes(map);

  calcDistances(nodes);

  return nodes
      .firstWhere((e) => e == Node(map.width - 1, map.height - 1))
      .distance;
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

  Set<Edge> edges;

  int distance = 0x7fffffffffffffff;

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

class Edge {
  int x;
  int y;
  int weight;

  Edge(this.x, this.y, this.weight);
}
