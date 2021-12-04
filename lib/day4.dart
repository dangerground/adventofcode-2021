import 'package:adventofcode2021/util/input.dart';

void main() {
  final task = Day4();

  final input = task.input();
  final solution1 = task.part1(input);
  final solution2 = task.part2(input);

  print("Solution part1: [ $solution1 ]");
  print("Solution part2: [ $solution2 ]");
}

class Day4 {
  static const int day = 4;

  List<List<String>> input() {
    return readLinesInBatches(day);
  }

  int part1(List<List<String>> input) {
    var numbers = input.first[0].split(",").map((e) => int.parse(e));
    var fields = getFields(input);

    for (var number in numbers) {
      for (int i = 0; i < fields.length; i++) {
        var field = fields[i];
        checkField(field, number);
        if (field.hasWon()) {
          print("$i: ${field.uncheckedNumbersSum()} * $number");
          return field.uncheckedNumbersSum() * number;
        }
      }
    }

//    printFields(fields);

    return -1;
  }

  void printFields(List<Field> fields) {
    for (var element in fields) {
      print(element);
      print("");
    }
  }

  List<Field> getFields(List<List<String>> input) {
    return input
        .skip(1)
        .map((batch) => Field(batch
            .map((line) => line
                .trim()
                .split(RegExp("\\s+"))
                .map((e) => Cell(int.parse(e)))
                .toList())
            .toList()))
        .toList();
  }

  int part2(List<List<String>> input) {
    var numbers = input.first[0].split(",").map((e) => int.parse(e));
    var fields = getFields(input);

    var toWin = <int>{};
    for (var number in numbers) {
      for (int i = 0; i < fields.length; i++) {
        var field = fields[i];
        checkField(field, number);
        if (field.hasWon()) {
          toWin.add(i);
        }
        if (toWin.length == fields.length) {
          print("$i: ${field.uncheckedNumbersSum()} * $number");
          //printFields(fields);
          return field.uncheckedNumbersSum() * number;
        }
      }
    }

    //printFields(fields);

    return -1;
  }

  void checkField(Field field, int number) {
    field.check(number);
  }
}

class Field {
  List<List<Cell>> internal = [];

  Field(List<List<Cell>> input) {
    internal = input;
  }

  void add(List<Cell> tmp) {
    internal.add(tmp);
  }

  List<Cell> operator [](int i) {
    return internal[i];
  }

  int uncheckedNumbersSum() {
    var x = 0;
    for (var line in internal) {
      line.where((e) => !e.checked).map((e) => e.number).forEach((e) {
        x += e;
      });
    }
    return x;
  }

  @override
  String toString() {
    var result = "";
    for (var line in internal) {
      for (var cell in line) {
        result += "$cell".padLeft(3);
      }
      result += "\n";
    }

    return result;
  }

  bool hasWon() {
    // by row
    for (var line in internal) {
      if (line.where((cell) => cell.checked).length == 5) {
        print("lwon $line");
        return true;
      }
    }

    // by column
    for (var c = 0; c < 5; c++) {
      if (internal.where((e) => e[c].checked).length == 5) {
        print("cwon $c");
        return true;
      }
    }
    return false;
  }

  void check(int number) {
    for (var line in internal) {
      for (var cell in line) {
        if (cell.number == number) {
          cell.checked = true;
          return;
        }
      }
    }
  }
}

class Cell {
  final int number;
  var checked = false;

  Cell(this.number);

  @override
  String toString() {
    if (checked) {
      return "x";
    }

    return "$number";
  }
}
