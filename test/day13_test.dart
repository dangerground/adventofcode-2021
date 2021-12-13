import 'package:adventofcode2021/day13.dart';
import 'package:test/test.dart';

void main() {
  final input = '''6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5'''
      .split("\n\n")
      .map((e) => e.split("\n").toList())
      .toList();

  group("part1", () {
    test('p1 - given example', () {
      // when
      final result = part1(input);

      // then
      expect(result, equals(17));
    });
  });

  group("part2", () {
    test('p2 - given example', () {
      // when
      final result = part2(input);

      // then
      expect(result, equals(666));
    });
  });
}
