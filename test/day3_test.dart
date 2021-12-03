import 'package:adventofcode2021/day3.dart';
import 'package:test/test.dart';

void main() {
  final task = Day3();

  final input = [
    '00100',
    '11110',
    '10110',
    '10111',
    '10101',
    '01111',
    '00111',
    '11100',
    '10000',
    '11001',
    '00010',
    '01010',
  ];

  group("part1", () {
    test('given example', () {
      // when
      final result = task.part1(input);

      // then
      expect(result, equals(198));
    });
  });

  group("part2", () {
    test('given example', () {
      // when
      final result = task.part2(input);

      // then
      expect(result, equals(230));
    });
  });
}
