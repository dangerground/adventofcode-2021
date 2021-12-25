import 'package:adventofcode2021/day25.dart';
import 'package:test/test.dart';

void main() {
  final input = '''v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>'''
      .split("\n")
      .toList();

  group("part1", () {
    test('p1 - given example', () {
      // when
      final result = part1(input);

      // then
      expect(result, equals(58));
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
