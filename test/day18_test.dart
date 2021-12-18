import 'package:adventofcode2021/day18.dart';
import 'package:test/test.dart';

void main() {

  group("part1", () {
    test('p1 - given example - m1', () {
      final input = '''[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]'''.split("\n").toList();
      // whenR
      final result = part1(input);

      // then
      expect(result, equals(143));
    });
    test('p1 - given example - m2', () {
      final input = '''[1,1]
[2,2]
[3,3]
[4,4]
[5,5]'''.split("\n").toList();
      // whenR
      final result = part1(input);

      // then
      expect(result, equals(143));
    });
  });

  group("part2", () {
    test('p2 - given example', () {
      final input = '''[[1,2],[[3,4],5]]'''.split("\n").toList();
      // when
      final result = part2(input);

      // then
      expect(result, equals(666));
    });
  });
}
