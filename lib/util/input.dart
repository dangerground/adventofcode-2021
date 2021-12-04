import 'dart:io';

List<String> readLinesAsString(int day) {
  var filePath = _dayToPath(day);
  return File(filePath).readAsLinesSync();
}

List<int> readLinesAsInt(int day) =>
    readLinesAsString(day).map((e) => int.parse(e)).toList();

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