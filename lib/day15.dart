import 'dart:math';

import 'package:adventofcode2021/util/input.dart';
import 'package:collection/collection.dart';

void main() {
  final input = readLinesAsString(15);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var map = LocalMap(input);

  var path = <WPoint>[WPoint(0, 0, map.m[0][0])];
  for (int i = 1; i < map.height; i++) {
    path.add(WPoint(i - 1, i, map.m[i - 1][i]));
    path.add(WPoint(i, i, map.m[i][i]));
  }

  var steps = 100;
  var optimizeFor = 3;
  do {
    var changed = false;
    for (int i = 0; i < path.length - optimizeFor; i += optimizeFor) {
      var sub = path.sublist(i, i + optimizeFor);

      var w1 = sub.weight();

      var opt = map.findBest(sub.first, sub.last, []);
      if (opt != sub) {
        var w2 = opt!.weight();
        // print("$w2 < $w1: $opt -- $sub");
        if (w2 < w1) {
          var nPath = path.sublist(0, i);
          nPath.addAll(opt);
          nPath.addAll(path.sublist(i + optimizeFor));

          // print("$i, ${i + optimizeFor}");
          // print(path.weight());
          // print(nPath.weight());
          // return w2;
          changed = true;
          path = nPath;
          continue;
        }
      }
    }

    if (!changed) {
      optimizeFor++;
      print("optimizeFor $optimizeFor");
      if (optimizeFor > 20) {
        break;
      }
    }

  } while (steps-- > 0);

  print(path);

  path.removeAt(0);
  return path.weight();
}

int part2(List<String> batches) {
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

  List<WPoint>? findBest(WPoint p1, WPoint p2, List<WPoint> path) {
    var nPath = [...path, p1];
    if (p1 == p2) {
      return nPath;
    }

    if (p1.x < 0 || p1.y < 0 || p1.x > p2.x || p1.y > p2.y) {
      return null;
    }

    var x1 = findBest(WPoint(p1.x, p1.y + 1, wAt(p1.x, p1.y + 1)), p2, nPath);
    var x2 = findBest(WPoint(p1.x + 1, p1.y, wAt(p1.x + 1, p1.y)), p2, nPath);

    if (x1 == null) {
      return x2;
    } else if (x2 == null) {
      return x1;
    } else {
      if (x1.weight() < x2.weight()) {
        return x1;
      } else {
        return x2;
      }
    }
  }

  int wAt(int x, int y) {
    if (x >= width || y >= height) {
      return 0x0ffffffffffff;
    }
    return m[y][x];
  }

  @override
  String toString() {
    var result = "";
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        var entry = m[y][x];
        result += "$entry";
      }
      result += "\n";
    }

    return result;
  }
}

class WPoint extends Point<int> {
  int w;

  WPoint(int x, int y, this.w) : super(x, y);
}

extension WPList on List<WPoint> {
  int weight() => map((e) => e.w).toList().sum;
}
