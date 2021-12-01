List<int> slidingWindow(List<int> input, int length) {
  var slidingWindows = <int>[];
  for (int i = 0; i <= input.length - length; i++) {
    var window = 0;
    for (int j = 0; j < length; j++) {
      window += input[i + j];
    }
    slidingWindows.add(window);
  }

  return slidingWindows;
}
