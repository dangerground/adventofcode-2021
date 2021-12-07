import 'dart:io';

List<String> readLinesAsString(int day) {
  var filePath = _dayToPath(day);
  return File(filePath).readAsLinesSync();
}

List<int> readLinesAsInt(int day) =>
    readLinesAsString(day).map(int.parse).toList();

String _dayToPath(int day) => "./assets/input/input_day$day.txt";

List<List<String>> readLinesInBatches(int day) {
  var lines = readLinesAsString(day);

  var batches = <List<String>>[];
  var batch = <String>[];
  for (var line in lines) {
    if (line.isEmpty) {
      batches.add(batch);
      batch = [];
      continue;
    }

    batch.add(line);
  }
  batches.add(batch);

  return batches;
}

extension StringToInt on String {
  List<int> toIntList() => split(",").map(int.parse).toList();
}
