import 'package:adventofcode2021/day17.dart';
import 'package:test/test.dart';

void main() {

  group("part1", () {
    test('p1 - given example', () {
      // when
      final result = solve(20, 30, -10, -5, part: 1);

      // then
      expect(result, equals(45));
    });
  });

  group("part2", () {
    test('p2 - given example', () {
      // when
      final result = solve(20, 30, -10, -5, part: 2);

      // then
      expect(result, equals(112));
    });
  });
}
