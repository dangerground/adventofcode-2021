import 'package:adventofcode2021/day7.dart';
import 'package:test/test.dart';

void main() {
  final input = '''16,1,2,0,4,2,7,1,2,14'''.split("\n").toList();

  group("part1", () {
    test('given example', () {
      // when
      final result = part1(input);

      // then
      expect(result, equals(37));
    });
  });

  group("part2", () {
    test('given example', () {
      // when
      final result = part2(input);

      // then
      expect(result, equals(168));
    });
  });
}
