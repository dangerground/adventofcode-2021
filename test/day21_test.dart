import 'package:adventofcode2021/day21.dart';
import 'package:test/test.dart';

void main() {
  final input = '''XXX'''.split("\n").toList();

  group("part1", () {
    test('p1 - given example', () {
      // when
      final result = part1(4, 8);

      // then
      expect(result, equals(739785));
    });
  });

  group("part2", () {
    test('p2 - given example', () {
      // when
      final result = part2(4, 8);

      // then
      expect(result, equals(666));
    });
  });
}
