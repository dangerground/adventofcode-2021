import 'package:adventofcode2021/day6.dart';
import 'package:test/test.dart';

void main() {
  final task = Day6();

  final input = [
    '3,4,3,1,2',
  ];

  group("part1", () {
    test('given example', () {
      // when
      final result = task.part1(input);

      // then
      expect(result, equals(5934));
    });
  });

  group("part2", () {
    test('given example', () {
      // when
      final result = task.part2(input);

      // then
      expect(result, equals(666));
    });
  });
}
