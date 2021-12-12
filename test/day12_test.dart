import 'package:adventofcode2021/day12.dart';
import 'package:test/test.dart';

void main() {
  final inputSmall = '''start-A
start-b
A-c
A-b
b-d
A-end
b-end'''
      .split("\n")
      .toList();

  final inputMedium = '''dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc'''
      .split("\n")
      .toList();

  final inputBig = '''fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW'''
      .split("\n")
      .toList();

  group("part1", () {
    test('given example small', () {
      // when
      final result = part1(inputSmall);

      // then
      expect(result, equals(10));
    });
    test('given example medium', () {
      // when
      final result = part1(inputMedium);

      // then
      expect(result, equals(19));
    });

    test('given example big', () {
      // when
      final result = part1(inputBig);

      // then
      expect(result, equals(226));
    });
  });

  group("part2", () {
    test('given example', () {
      // when
      final result = part2(inputSmall);

      // then
      expect(result, equals(666));
    });
  });
}
