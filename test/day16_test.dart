import 'package:adventofcode2021/day16.dart';
import 'package:test/test.dart';

void main() {
  final input = '''A0016C880162017C3686B18A3D4780'''.split("\n").toList();

  group("part1", () {
    test('p1 - given example', () {
      // when
      final result = part1(input);

      // then
      expect(result, equals(666));
    });
  });

  group("part2", () {
    test('p2 - given example', () {
      // when
      final result = part2(input);

      // then
      expect(result, equals(666));
    });
  });
}
