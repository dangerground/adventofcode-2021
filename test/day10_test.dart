import 'package:adventofcode2021/day10.dart';
import 'package:test/test.dart';

void main() {
  final input = '''[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]'''.split("\n").toList();

  group("part1", () {
    test('given example', () {
      // when
      final result = part1(input);

      // then
      expect(result, equals(26397));
    });
  });

  group("part2", () {
    test('given example', () {
      // when
      final result = part2(input);

      // then
      expect(result, equals(288957));
    });
  });
}
