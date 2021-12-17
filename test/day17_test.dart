import 'package:adventofcode2021/day17.dart';
import 'package:test/test.dart';

void main() {

  group("part1", () {
    test('p1 - given example', () {
      // when
      final result = part1(20, 30, -10, -5);

      // then
      expect(result, equals(45));
    });
  });

  group("part2", () {
    test('p2 - given example', () {
      // when
      final result = part2(20, 30, -10, -5);

      // then
      expect(result, equals(112));
    });
  });
}
