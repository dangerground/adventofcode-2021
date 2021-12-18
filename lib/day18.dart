import 'package:adventofcode2021/util/input.dart';
import 'package:quantity/quantity.dart';

void main() {
  final input = readLinesAsString(18);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var snails = input
      .map((e) => parseLine(e, 0))
      .reduce((value, element) => value + element);

  var exploded = false;
  print("snails: $snails");
  do {
    exploded = snails.explode();
    print("after explodes: $snails");
    snails.split();
    print("after splits  : $snails");
  } while (exploded);

  print("final: $snails");
  return 5;
}

Snail parseLine(String str, int depth) {
  //  new  sub-snail
  if (str.startsWith("[")) {
    int i = 1;
    int brackets = 0;
    do {
      if (str[i] == "[") {
        brackets++;
      } else if (str[i] == "]") {
        brackets--;
      }
      i++;
    } while (brackets > 0);
    var left = parseLine(str.substring(1, i), depth + 1);

    int rStart = i + 1;
    i = 0;
    brackets = 0;
    do {
      if (str[rStart + i] == "[") {
        brackets++;
      } else if (str[rStart + i] == "]") {
        brackets--;
      }
      i++;
    } while (brackets > 0);
    var right = parseLine(str.substring(rStart, rStart + i), depth + 1);
    return Snail(left, right, depth);
  }

  // new num
  return Snail(null, null, depth, value: int.parse(str[0]));
}

int part2(List<String> input) {
  return -1;
}

class Snail {
  Snail? parent;

  Snail? left;
  Snail? right;
  int? value;
  int depth;

  Snail(this.left, this.right, this.depth, {this.value}) {
    if (left != null) left!.parent = this;
    if (right != null) right!.parent = this;
  }

  Snail operator +(Snail other) {
    this.incDepth();
    other.incDepth();
    return Snail(this, other, 0);
  }

  void incDepth() {
    if (left != null) left!.incDepth();
    if (right != null) right!.incDepth();
    depth++;
  }

  bool explode() {
    bool changed = false;
    if (depth >= 4 && value == null) {
      // left
      var l = firstLeft(parent);
      if (l != null && l != this) {
        l.value = l.value! + left!.value!;
      }

      // right
      var r = firstRight(parent);
      if (r != null && r != this) {
        r.value = r.value! + right!.value!;
      }

      left = null;
      right = null;
      value = 0;
      return true;
    }

    if (left != null && left!.explode()) {
      return true;
    }
    if (right != null && right!.explode()) {
      return true;
    }

    return false;
  }

  Snail? firstRight(Snail? p) {

    while (p != null) {
      if (p.right!.value != null) {
        return p.right;
      }
      if (p.parent != null && p.parent!.right != p) {
        var firstLeft = p.parent!.right;
        while (firstLeft != null) {
          if (firstLeft.value != null) {
            return firstLeft;
          }
          firstLeft = firstLeft.left;
        }
      }
      p = p.parent;
    }

    return null;
  }

  Snail? firstLeft(Snail? p) {

    while (p != null) {
      if (p.left!.value != null) {
        return p.left;
      }
      if (p.parent != null && p.parent!.left != p) {
        var firstRight = p.parent!.left;
        while (firstRight != null) {
          if (firstRight.value != null) {
            return firstRight;
          }
          firstRight = firstRight.right;
        }
      }
      p = p.parent;
    }

    return null;
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    if (other is! Snail) {
      return false;
    }
    if (value == null) {
      return other.left == left && other.right == right;
    }

    return value == other.value;
  }

  @override
  String toString() {
    if (value != null) {
      return "$value";
    } else {
      return "[$left,$right]";
    }
  }

  split() {
    bool changed = false;
    if (value != null && value! > 9) {
      var lVal = value! ~/ 2;
      left = Snail(null, null, depth + 1, value: lVal);
      right = Snail(null, null, depth + 1, value: value! - lVal);
      value = null;
      return true;
    }

    if (left != null) changed &= left!.split();
    if (right != null) changed &= right!.split();

    return changed;
  }
}
