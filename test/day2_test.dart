import 'package:adventofcode2021/day2.dart';
import 'package:test/test.dart';

void main() {
  final task = Day2();

  final input = [
    'forward 5',
    'down 5',
    'forward 8',
    'up 3',
    'down 8',
    'forward 2',
  ];

  group("part1", () {
    test('given example', () {
      // when
      final result = task.part1(input);

      // then
      expect(result, equals(150));
    });
  });

  group("part2", () {
    test('given example', () {
      // when
      final result = task.part2(input);

      // then
      expect(result, equals(900));
    });
  });
}
