import 'package:adventofcode2021/util/input.dart';

void main() {
  final input = readLinesInBatches(4);

  print("Solution part1: [ ${part1(input)} ]");
  print("Solution part2: [ ${part2(input)} ]");
}

int part1(List<List<String>> batches) {
  var drawnNumbers = getDrawnNumbers(batches);
  var fields = getBoards(batches);

  for (var drawnNumber in drawnNumbers) {
    for (var field in fields) {
      field.mark(drawnNumber);

      if (field.hasWon()) {
        return field.unmarkedNumbersSum() * drawnNumber;
      }
    }
  }

  return -1;
}

Iterable<int> getDrawnNumbers(List<List<String>> batches) {
  return batches.first[0].toIntList();
}

List<Board> getBoards(List<List<String>> input) {
  return input.skip(1).map((batch) => Board.fromBatch(batch)).toList();
}

int part2(List<List<String>> batches) {
  var drawnNumbers = getDrawnNumbers(batches);
  var boards = getBoards(batches);

  var boardsWon = <Board>{};
  for (var drawnNumbers in drawnNumbers) {
    for (var field in boards) {
      field.mark(drawnNumbers);
      if (field.hasWon()) {
        boardsWon.add(field);
      }

      if (boardsWon.length == boards.length) {
        return field.unmarkedNumbersSum() * drawnNumbers;
      }
    }
  }

  return -1;
}

void printBoards(List<Board> boards) {
  for (var board in boards) {
    print(board);
    print("");
  }
}

class Board {
  List<List<Number>> numbers = [];

  Board.fromBatch(List<String> batch) {
    numbers = batch.map(rowToNumbers).toList();
  }

  List<Number> rowToNumbers(String row) {
    return row
        .trim()
        .split(RegExp("\\s+"))
        .map((e) => Number(int.parse(e)))
        .toList();
  }

  int unmarkedNumbersSum() {
    var x = 0;
    for (var row in numbers) {
      row.where((e) => !e.marked).map((e) => e.value).forEach((e) {
        x += e;
      });
    }
    return x;
  }

  bool hasWon() {
    // by row
    for (var row in numbers) {
      if (row.where((number) => number.marked).length == 5) {
        return true;
      }
    }

    // by column
    for (var c = 0; c < 5; c++) {
      if (numbers.where((row) => row[c].marked).length == 5) {
        return true;
      }
    }

    return false;
  }

  void mark(int drawnNumber) {
    for (var row in numbers) {
      for (var number in row) {
        if (number.value == drawnNumber) {
          number.marked = true;
          return;
        }
      }
    }
  }

  @override
  String toString() {
    var result = "";
    for (var row in numbers) {
      for (var number in row) {
        result += "$number".padLeft(3);
      }
      result += "\n";
    }

    return result;
  }
}

class Number {
  final int value;
  var marked = false;

  Number(this.value);

  @override
  String toString() {
    if (marked) {
      return "x";
    }

    return "$value";
  }
}
