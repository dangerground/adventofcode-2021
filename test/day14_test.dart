import 'package:adventofcode2021/day14.dart';
import 'package:test/test.dart';

void main() {
  final input = '''NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C'''
      .split("\n\n")
      .map((e) => e.split("\n").toList())
      .toList();

  group("part1", () {
    test('p1 - given example', () {
      // when
      final result = part1(input);

      // thenR
      expect(result, equals(1588));
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
