import 'package:adventofcode2021/day9.dart';
import 'package:test/test.dart';

void main() {
  final input = '''2199943210
3987894921
9856789892
8767896789
9899965678'''
      .split("\n")
      .toList();

  group("part1", () {
    test('given example', () {
      // when
      final result = part1(input);

      // then
      expect(result, equals(15));
    });
  });

  group("part2", () {
    test('given example', () {
      // when
      final result = part2(input);

      // then
      expect(result, equals(1134));
    });
  });
}
