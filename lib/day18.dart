import 'package:adventofcode2021/util/input.dart';
import 'package:quantity/quantity.dart';

void main() {
  final input = readLinesAsString(18);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<String> input) {
  var snails = input.map((e) => parseLine(e, 0)).reduce((value, element) {
    //print("  $value");
    //print("+ $element");
    var added = value + element;

    var exploded = false;
    var splitted = false;
    do {
//      print("n $added");
      exploded = false;
      while (added.explode()) {
        exploded = true;
        //print("o $added");
      }
      splitted = added.split();
      //print("| $added");
    } while (exploded || splitted);

//    print("= $added");
//    print("");
    return added;
  });

  print("final: $snails");
  return snails.magnitude();
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

  Snail(this.left, this.right, this.depth, {this.value, this.parent}) {
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
    if (left != null && left!.explode()) {
      return true;
    }
    if (right != null && right!.explode()) {
      return true;
    }

    if (depth >= 4 && value == null) {
      // left
      var l = getLeft(this);
      if (l != null && l != this) {
        l.value = l.value! + left!.value!;
      }

      // right
      var r = getRight(this);
      if (r != null && r != this) {
        r.value = r.value! + right!.value!;
      }

      left = null;
      right = null;
      value = 0;
      return true;
    }

    return false;
  }

  Snail? getRight(Snail? p) {
    if (p == null) {
      return null;
    }

    if (p.value != null) {
      return p;
    }

    p = p.right;
    while (p != null && p.parent?.right == p) {
      p = p.parent;
    }

    if (p?.parent?.right != null) {
      var firstLeft = p?.parent?.right;
      while (firstLeft != null) {
        if (firstLeft.value != null) {
          return firstLeft;
        }
        firstLeft = firstLeft.left;
      }
    }

    return null;
  }

  // _a_ => a ok
  // [a,_b_] =>  a ok
  // [a,_[b,c]_] => a ok
  // [[a,b],_c_] => b
  // [[a,b],_[c,d]_] => b
  // [[a,[b,c]],_d_] => c
  Snail? getLeft(Snail? p) {
    if (p == null) {
      return null;
    }

    if (p.value != null) {
      return p;
    }

    while (p != null && p.parent?.left == p) {
      p = p.parent;
    }

    if (p?.parent?.left != null) {
      var firstRight = p?.parent?.left;
      while (firstRight != null) {
        if (firstRight.value != null) {
          return firstRight;
        }
        firstRight = firstRight.right;
      }
    }

    return null;
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
    if (left != null && left!.split()) return true;
    if (right != null && right!.split()) return true;

    if (value != null && value! > 9) {
      var lVal = (value!.toDouble() / 2).floor();
      var rVal = (value!.toDouble() / 2).ceil();
      left = Snail(null, null, depth + 1, value: lVal, parent: this);
      right = Snail(null, null, depth + 1, value: rVal, parent: this);
      value = null;
      return true;
    }

    return false;
  }

  int magnitude() {
    var magnitude = 0;
    if (left != null) {
      magnitude += left!.magnitude() * 3;
    }
    if (right != null) {
      magnitude += right!.magnitude() * 2;
    }

    if (value != null) {
      magnitude += value!;
    }

    return magnitude;
  }
}
