import 'dart:math';

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

  List<AST> packets = getSubpackages(binaryString);

  print(packets);

  return versions;
}

List<AST> getSubpackages(String binaryString, {int? count}) {
//  print("inner: $binaryString");

  var packets = <AST>[];

  var remaining = binaryString;
  do {
    if (count != null && --count < 0) {
      //print("skip more");
      break;
    }
    if (remaining.replaceAll('0', '').isEmpty) {
      //print("skip padding");
      break;
    }
    //print("r $remaining");
    var version = getVersion(remaining);

    versions += version;

    var type = getType(remaining);
    var payloadLength = 0;
    var header = 6;
    var ast = AST(type, [], 0, 0);

    if (type == 4) {
      var literals = readLiterals(remaining);
      payloadLength = literals.length * 5;
      //print("literals: $literals");
      ast.value =
          Binary(literals.reduce((value, element) => "$value$element")).toInt();
    } else {
      var length = getLength(remaining);
      header += 1;
      if (length == 0) {
        header += 15;
        var subPackagelength = getSubPacketsLength(remaining);
        //print("subpackets-length: $subPackagelength");
        payloadLength += subPackagelength;
        var subPackage = remaining.substring(header, header + payloadLength);
        //print("parse [$subPackage] $payloadLength");
        var subpackages = getSubpackages(subPackage);
        ast.children = subpackages;
      } else {
        header += 11;
        var num = getSubPacketsCount(remaining);
        //print("subpackets-count: $num");
        var subPackage = remaining.substring(header);
        var subpackages = getSubpackages(subPackage, count: num);
        ast.children = subpackages;
        //print("check $subPackage");

        payloadLength += subpackages.map((e) => e.length).sum;
        //print("parse [$subPackage] $payloadLength");
      }
    }

    var packetLength = header + payloadLength;
    ast.length = packetLength;
    packets.add(ast);

//    print("pl: $packetLength - $header, $payloadLength");

    remaining = remaining.substring(packetLength);
  } while (remaining.isNotEmpty);

  print("out; $packets");
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
  //print("version: $bits ($value)");
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
  var length = Binary(bits).toInt();
  //print("length: $bits ($length)");
  return length;
}

int getSubPacketsCount(String binaryString) {
  var bits = binaryString.substring(7, 7 + 11);
  var value = Binary(bits).toInt();
  //print("subpackets-c: $bits ($value)");
  return value;
}

int getSubPacketsLength(String binaryString) {
  var bits = binaryString.substring(7, 7 + 15);
  //print("subpackets-l: $bits");
  return Binary(bits).toInt();
}

int part2(List<String> input) {
  var binaryString = hexToBin(input[0]);

  List<AST> packets = getSubpackages(binaryString);

  var result = solveAST(packets[0]);

  print(packets);

  return result.value;
}

AST solveAST(AST ast) {
  switch (ast.type) {
    case literal:
      return ast;
    case sum:
      return AST(literal, [],
          ast.children.map((e) => solveAST(e)).map((e) => e.value).sum, 0);
    case product:
      return AST(
          literal,
          [],
          ast.children
              .map((e) => solveAST(e))
              .map((e) => e.value)
              .reduce((value, element) => value * element),
          0);
    case minimum:
      return AST(
          literal,
          [],
          ast.children
              .map((e) => solveAST(e))
              .map((e) => e.value)
              .reduce((value, element) => min(value, element)),
          0);
    case maximum:
      return AST(
          literal,
          [],
          ast.children
              .map((e) => solveAST(e))
              .map((e) => e.value)
              .reduce((value, element) => max(value, element)),
          0);

    case lessThan:
      return AST(literal, [],
          solveAST(ast.children[0]).value < solveAST(ast.children[1]).value ? 1 : 0, 0);

    case greaterThan:
      return AST(literal, [],
          solveAST(ast.children[0]).value > solveAST(ast.children[1]).value ? 1 : 0, 0);

    case equalTo:
      var first = solveAST(ast.children[0]);
      var second = solveAST(ast.children[1]);

      return AST(literal, [],
          first.value == second.value ? 1 : 0, 0);
  }

  return AST(unknown, [], 0, 0);
}

class AST {
  late PType type;
  late List<AST> children; // non-literals
  late int value; // literal only
  late int length;

  AST(this.type, this.children, this.value, this.length);

  @override
  String toString() {
    return "$type ($value) -> $children";
  }
}

typedef PType = int;

const PType unknown = -1;
const PType sum = 0;
const PType product = 1;
const PType minimum = 2;
const PType maximum = 3;
const PType literal = 4;
const PType greaterThan = 5;
const PType lessThan = 6;
const PType equalTo = 7;
