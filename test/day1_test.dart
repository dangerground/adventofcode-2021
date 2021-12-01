import 'package:adventofcode2021/day1.dart';
import 'package:test/test.dart';

void main() {
  final day1 = Day1();

  group("part1", () {
    test('given example', () {
      // given
      final input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263];

      // when
      final result = day1.part1calc(input);

      // then
      expect(result,  equals(7));
    });
    test('solve', () {
      // when
      final result = day1.part1solution();

      print("Solution part1: $result");
    });
  });

  group("part2", () {
    test('given example', () {
      // given
      final input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263];

      // when
      final result = day1.part2calc(input);

      // then
      expect(result,  equals(5));
    });
    test('solve', () {
      // when
      final result = day1.part2solution();

      print("Solution part2: $result");
    });
  });
}
