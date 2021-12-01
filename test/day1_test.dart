import 'package:adventofcode2021/day1.dart';
import 'package:test/test.dart';

void main() {
  final day1 = Day1();

  final input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263];

  group("part1", () {
    test('given example', () {
      // when
      final result = day1.part1(input);

      // then
      expect(result, equals(7));
    });
  });

  group("part2", () {
    test('given example', () {
      // when
      final result = day1.part2(input);

      // then
      expect(result, equals(5));
    });
  });
}
