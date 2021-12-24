import 'dart:math';

void main() {
  print("Solution part1: [ ${part1(7, 6)} ]");
  print("Solution part2: [ ${part2(7, 6)} ]");
}

int part1(int p1Pos, int p2Pos) {
  int p1Score = 0;
  int p2Score = 0;

  var dice = Dice();

  while (true) {
    var d1 = dice.next();
    var d2 = dice.next();
    var d3 = dice.next();
    p1Pos = (p1Pos + d1 + d2 + d3);
    while (p1Pos > 10) {
      p1Pos -= 10;
    }
    p1Score += p1Pos;
    print("Player 1 rolls $d1+$d2+$d3 and moves to space $p1Pos for a total score of $p1Score.");
    if (p1Score >= 1000) {
      break;
    }

    var d4 = dice.next();
    var d5 = dice.next();
    var d6 = dice.next();
    p2Pos = (p2Pos + d4 + d5 + d6);
    while (p2Pos > 10) {
      p2Pos -= 10;
    }
    p2Score += p2Pos;
    print("Player 2 rolls $d4+$d5+$d6 and moves to space $p2Pos for a total score of $p2Score.");
    if (p2Score >= 1000) {
      break;
    }
  }

  return dice.count * min(p1Score, p2Score);
}

int part2(int p1Start, int p2Start) {
  return -1;
}

class Dice {
  int num = 0;
  int count = 0;

  int next() {
    count++;
    num++;
    if (num > 100) {
      num = 1;
    }

    return num;
  }
}