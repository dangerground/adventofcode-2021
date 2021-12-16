import 'package:adventofcode2021/util/input.dart';
import 'package:collection/collection.dart';
import 'package:quantity/quantity.dart';

void main() {
  final input = readLinesAsString(16);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int versions = 0;
int part1(List<String> input) {
  var binaryString = hexToBin(input[0]);

  print(binaryString);

  List<String> packets = getSubpackages(binaryString);

  print(packets);

  return versions;
}

List<String> getSubpackages(String binaryString, {int? count}) {

  var packets = <String>[];

  var remaining = binaryString;
  do {
    if (count != null && count-- > 0) {
      break;
    }
    if (remaining.replaceAll('0', '').isEmpty) {
      print("skip padding");
      break;
    }
    print("r $remaining");
    var version = getVersion(remaining);

    versions += version;

    var type = getType(remaining);
    var payloadLength = 0;
    var header = 6;

    if (type == 4) {
      var literals = readLiterals(remaining);
      payloadLength = literals.length*5;
      //print("literals: $literals");
    } else {
      var length = getLength(remaining);
      header += 1;
      if (length == 15) {
        header += 15;
        var subPackagelength = getSubPacketsLength(remaining);
        //print("subpackets-length: $subPackagelength");
        payloadLength += subPackagelength;
        var subPackage = remaining.substring(header, header+payloadLength);
        print("parse $subPackage $payloadLength");
        packets.addAll(getSubpackages(subPackage));
      } else {
        header += 11;
        var num = getSubPacketsCount(remaining);
        //print("subpackets-count: $subPackets");
        var subPackage = remaining.substring(header, header+payloadLength);
        print("parse $subPackage $payloadLength");
        var subpackages = getSubpackages(subPackage, count: num);
        packets.addAll(subpackages);

        payloadLength += subpackages.map((e) => e.length).sum;
      }
    }
  /*
  00111000000000000110111101000101001010010001001000000000
  VVVTTTILLLLLLLLLLLLLLLAAAAAAAAAAABBBBBBBBBBBBBBBB
  */

    var packetLength = header + payloadLength;

//    print("pl: $packetLength - $header, $payloadLength");

    remaining = remaining.substring(packetLength);
  } while (remaining.isNotEmpty);
  return packets;
}

List<String> readLiterals(String binaryString) {
  var literals = <String>[];

  var end = false;
  var i = 0;
  do {
    String literal = binaryString.substring(6 + i, 6 + i + 5);
    //print("l $literal");

    end = literal[0] == "0";
    literals.add(literal.substring(1));

    i += 5;
  } while (!end);

  return literals;
}

String hexToBin(String input) {
  return input
      .split("")
      .map((e) => Hexadecimal(e).toInt().toRadixString(2).padLeft(4, '0'))
      .reduce((value, element) => "$value$element");
}

int getVersion(String binaryString) {
  var bits = binaryString.substring(0, 3);
  var value = Binary(bits).toInt();
  print("version: $bits ($value)");
  return value;
}

int getType(String binaryString) {
  var bits = binaryString.substring(3, 6);
  var value = Binary(bits).toInt();
  //print("type: $bits ($value)");
  return value;
}

int getLength(String binaryString) {
  var bits = binaryString.substring(6, 7);
  var length = Binary(bits).toInt() == 1 ? 11 : 15;
  //print("length: $bits ($length)");
  return length;
}

int getSubPacketsCount(String binaryString) {
  var bits = binaryString.substring(7, 7 + 11);
  var value = Binary(bits).toInt();
  print("subpackets-c: $bits ($value)");
  return value;
}

int getSubPacketsLength(String binaryString) {
  var bits = binaryString.substring(7, 7 + 15);
  //print("subpackets-l: $bits");
  return Binary(bits).toInt();
}

int part2(List<String> input) {
  return -1;
}
