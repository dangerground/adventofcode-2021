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

  List<String> input() {
    return readLinesAsString(day);
  }

  int part1(List<String> input) {
    var numbers = input[0].split(",").map((e) => int.parse(e));
    var fields = getFields(input);

    for (var number in numbers) {
      for (int i = 0; i < fields.length; i++) {
        var field = fields[i];
        checkField(field, number);
        if (field.hasWon()) {
          print("$i: ${field.uncheckedNumbersSum()} * $number");
//          printFields(fields);
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

  List<Field> getFields(List<String> input) {
    var fields = <Field>[];
    var field = Field();
    for (var element in input.skip(2)) {
      if (element.isEmpty) {
        fields.add(field);
        field = Field();
        continue;
      }

      var tmp = element
          .trim()
          .split(RegExp("\\s+"))
          .map((e) => Cell(int.parse(e)))
          .toList();

      field.add(tmp);
    }
    fields.add(field);

    var usableFields =
        fields.where((element) => element[0].isNotEmpty).toList();

    return usableFields;
  }

  int part2(List<String> input) {

    var numbers = input[0].split(",").map((e) => int.parse(e));
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
    for (var line in field.lines()) {
      for (var cell in line) {
        if (cell.number == number) {
          cell.checked = true;
          return;
        }
      }
    }
  }
}

class Field {
  List<List<Cell>> internal = [];

  Field();

  Field.from(Iterable<List<Cell>> defined) {
    internal = defined.toList();
  }

  void add(List<Cell> tmp) {
    internal.add(tmp);
  }

  List<Cell> operator [](int i) {
    return internal[i];
  }

  List<List<Cell>> lines() {
    return internal;
  }

  int uncheckedNumbersSum() {
    var x = 0;
    for (var line in internal) {
      for (var cell in line) {
        if (!cell.checked) {
          x += cell.number;
        }
      }
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
    var result = "";
    // by row
    for (var line in internal) {
      var lineWon = 0;
      for (var cell in line) {
        if (cell.checked) lineWon++;
      }

      if (lineWon == 5) {
        print("lwon $line");
        return true;
      }
    }

    // by column
    for (var c = 0; c < 5; c++) {
      var cWon = 0;
      for (var r = 0; r < 5; r++) {
        if (internal[r][c].checked) cWon++;
      }
      if (cWon == 5) {
        print("cwon $c");
        return true;
      }
    }
    return false;
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
