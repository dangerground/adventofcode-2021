import 'dart:math';

import 'package:adventofcode2021/util/input.dart';
import 'package:quantity/quantity.dart';

void main() {
  final input = readLinesAsString(17);
  // target area: x=96..125, y=-144..-98

  print("Solution part1: [ ${part1(96, 125, -144, -98)} ]");
  print("Solution part2: [ ${part2(96, 125, -144, -98)} ]");
}

int part1(int xMin, int xMax, int yMin, int yMax) {

  var options = <Point>{};
var  heighest = 0;
  for (int x = xMax; x > 0; x--) {
    for (int y = yMin*-1; y >= 0; y--) {
  //var  x = 9;
  //var  y = 0;
      var pos = Point<int>(0, 0);
      var diff = Point<int>(x, y);
      Point<int>? lastIn;
      var possible = 0;
      do {
//        print("pos $pos - $diff");
        if (pos.x >= xMin && pos.x <= xMax && pos.y >= yMin && pos.y <= yMax) {
          //print("found $pos");
          lastIn = pos;
        }

        possible = max(possible, pos.y);
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
      if (lastIn != null) {
        options.add(Point(x, y));
        heighest = max(heighest, possible);
      }
    }
  }
  print(heighest);

  return heighest;
}

int part2(int xMin, int xMax, int yMin, int yMax) {
  return -1;
}
