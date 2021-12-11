import 'package:adventofcode2021/day11.dart';
import 'package:test/test.dart';

void main() {
  final input = '''5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526'''
      .split("\n")
      .toList();

  group("part1", () {
    test('given example', () {
      // when
      final result = part1(input);

      // then
      expect(result, equals(1656));
    });
  });

  group("part2", () {
    test('given example', () {
      // when
      final result = part2(input);

      // then
      expect(result, equals(195));
    });
  });
}
