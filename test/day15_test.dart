import 'package:adventofcode2021/day15.dart';
import 'package:test/test.dart';

void main() {
  final input = '''1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581'''
      .split("\n")
      .toList();

  group("part1", () {
    test('p1 - given example', () {
      // when
      final result = part1(input);

      // thenR
      expect(result, equals(40));
    });
  });

  group("part2", () {
    test('p2 - given example', () {
      // when
      final result = part2(input);

      // then
      expect(result, equals(2188189693529));
    });
  });
}
