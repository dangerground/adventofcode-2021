import 'dart:math';

import 'package:adventofcode2021/util/input.dart';
import 'package:quantity/quantity.dart';

void main() {
  // target area: x=96..125, y=-144..-98

  print("Solution part1: [ ${solve(96, 125, -144, -98, part: 1)} ]");
  print("Solution part2: [ ${solve(96, 125, -144, -98, part: 2)} ]");
}

int solve(int xMin, int xMax, int yMin, int yMax, {int part = 1}) {
  var options = <Point>{};
  var highest = 0;
  for (int x = xMax; x > 0; x--) {
    for (int y = yMin * -1; y >= yMin; y--) {
      var pos = Point<int>(0, 0);
      var diff = Point<int>(x, y);
      var inTarget = false;
      var localHighest = 0;
      do {
        localHighest = max(localHighest, pos.y);

        if (inTargetArea(pos, xMin, xMax, yMin, yMax)) {
          inTarget = true;
        }

        pos = Point(pos.x + diff.x, pos.y + diff.y);
        if (diff.x != 0) {
          diff = Point(diff.x - (diff.x ~/ diff.x.abs()), diff.y - 1);
        } else {
          if (pos.y < yMin) {
            break;
          }
          diff = Point(0, diff.y - 1);
        }
      } while (pos.x <= xMax);

      if (inTarget) {
        options.add(Point(x, y));
        highest = max(highest, localHighest);
      }
    }
  }

  if (part == 1) {
    return highest;
  } else {
    return options.length;
  }
}

bool inTargetArea(Point<int> pos, int xMin, int xMax, int yMin, int yMax) =>
    pos.x >= xMin && pos.x <= xMax && pos.y >= yMin && pos.y <= yMax;
