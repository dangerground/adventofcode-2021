import 'dart:math';

import 'package:adventofcode2021/util/input.dart';
import 'package:adventofcode2021/util/maps.dart';

void main() {
  final input = readLinesInBatches(13);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<List<String>> batches) {
  var map = AccessMap();
  batches[0].map(toPoint).forEach((element) {
    map.set(element.x, element.y, 1);
  });

//  print(map);

  batches[1].take(1).forEach((element) {
    var testY = element.split("fold along y=");
    var testX = element.split("fold along x=");
    if (testX.length == 2) {
      map = foldX(map, int.parse(testX[1]));
    } else {
      map = foldY(map, int.parse(testY[1]));
    }
  });
//  print(map);

  var count = 0;
  for (int y = 0; y < map.height; y++) {
    for (int x = 0; x < map.width; x++) {
      count += ((map.get(x, y) ?? 0) > 0 ? 1 : 0);
    }
  }

  return count;
}

AccessMap foldY(AccessMap map, int foldAt) {
  var newMap = AccessMap();
  for (int y = 0; y <= foldAt; y++) {
    for (int x = 0; x < map.width; x++) {
      newMap.set(
          x, y, (map.get(x, y) ?? 0) + (map.get(x, map.height - 1 - y) ?? 0));
    }
  }
  return newMap;
}

AccessMap foldX(AccessMap map, int foldAt) {
  var newMap = AccessMap();
  for (int y = 0; y < map.height-1; y++) {
    for (int x = 0; x <= foldAt; x++) {
      newMap.set(
          x, y, (map.get(x, y) ?? 0) + (map.get(map.width - 1 - x, y) ?? 0));
    }
  }
  return newMap;
}

Point<int> toPoint(String e) {
  var p = e.split(",");
  return Point<int>(int.parse(p[0]), int.parse(p[1]));
}

int part2(List<List<String>> batches) {
  var map = AccessMap();
  var points = batches[0].map(toPoint).toSet();

  print(points);

  batches[1].forEach((element) {
    var testY = element.split("fold along y=");
    var testX = element.split("fold along x=");
    if (testX.length == 2) {
      print("foldX");
      var foldAt = int.parse(testX[1]);
      var newPoints = <Point<int>>{};
      for (var point in points) { 
          if (point.x > foldAt) {
            newPoints.add(Point(2*foldAt-point.x, point.y));
          }  else {
            newPoints.add(point);
          }
      }
      points = newPoints;
    } else {
      print("foldY");

      var foldAt = int.parse(testY[1]);
      var newPoints = <Point<int>>{};
      for (var point in points) {
        if (point.y > foldAt) {
          newPoints.add(Point(point.x,2*foldAt-point.y));
        }  else {
          newPoints.add(point);
        }
      }
      points = newPoints;
    }
    print(map);
  });

  points.forEach((element) {
    map.set(element.x, element.y, 1);
  });

  print(map);

  return -1;
}
