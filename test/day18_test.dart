import 'package:adventofcode2021/day18.dart';
import 'package:test/test.dart';

void main() {
  group("part1", () {
    test('p1 - given example - m1', () {
      final input = '''[[1,2],[[3,4],5]]'''
          .split("\n")
          .toList();
      // whenR
      final result = part1(input);

      // then
      expect(result, equals(143));
    });

    test('p1 - given example - m2', () {
      final input = '''[[[[0,7],4],[[7,8],[6,0]]],[8,1]]'''
          .split("\n")
          .toList();
      // whenR
      final result = part1(input);

      // then
      expect(result, equals(1384));
    });

    test('p1 - given example - m3', () {
      final input = '''[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]'''
          .split("\n")
          .toList();
      // whenR
      final result = part1(input);

      // then
      expect(result, equals(4140));
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
