import 'package:adventofcode2021/day5.dart';
import 'package:test/test.dart';

void main() {
  final input = '''0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2'''
      .split("\n");

  group("part1", () {
    test('given example', () {
      // when
      final result = part1(input);

      // then
      expect(result, equals(5));
    });
  });

  group("part2", () {
    test('given example', () {
      // when
      final result = part2(input);

      // then
      expect(result, equals(12));
    });
  });
}
