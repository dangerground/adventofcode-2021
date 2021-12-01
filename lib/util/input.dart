import 'dart:io';

List<int> readLinesAsInt(int day) {
  var filePath = _dayToPath(day);
  return File(filePath).readAsLinesSync().map((e) => int.parse(e)).toList();
}

String _dayToPath(int day) => "./assets/input/input_day$day.txt";
