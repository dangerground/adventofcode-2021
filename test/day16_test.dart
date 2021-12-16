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
    test('p2 - given example sum', () {
      // when
      final result = part2("C200B40A82".split("\n").toList());

      // then
      expect(result, equals(3));
    });
    test('p2 - given example product', () {
      // when
      final result = part2("04005AC33890".split("\n").toList());

      // then
      expect(result, equals(54));
    });
    test('p2 - given example minimum', () {
      // when
      final result = part2("880086C3E88112".split("\n").toList());

      // then
      expect(result, equals(7));
    });
    test('p2 - given example maximum', () {
      // when
      final result = part2("CE00C43D881120".split("\n").toList());

      // then
      expect(result, equals(9));
    });
    test('p2 - given example less than', () {
      // when
      final result = part2("D8005AC2A8F0".split("\n").toList());

      // then
      expect(result, equals(1));
    });
    test('p2 - given example greater than', () {
      // when
      final result = part2("F600BC2D8F".split("\n").toList());

      // then
      expect(result, equals(0));
    });
    test('p2 - given example equals', () {
      // when
      final result = part2("9C005AC2F8F0".split("\n").toList());

      // then
      expect(result, equals(0));
    });
    test('p2 - given example 1 + 3 = 2 * 2', () {
      // when
      final result = part2("9C0141080250320F1802104A08".split("\n").toList());

      // then
      expect(result, equals(1));
    });
  });
}
