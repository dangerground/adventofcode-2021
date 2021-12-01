import 'dart:io';

List<String> readLinesAsString(int day) {
  var filePath = _dayToPath(day);
  return File(filePath).readAsLinesSync();
}

List<int> readLinesAsInt(int day) =>
    readLinesAsString(day).map((e) => int.parse(e)).toList();

String _dayToPath(int day) => "./assets/input/input_day$day.txt";
