extension StringContainsAll on String {
  bool containsAll(Iterable<String> contain) {
    for (var value in contain) {
      if (!contains(value)) {
        return false;
      }
    }

    return true;
  }

  Iterable<String> chars() {
    var res = <String>[];
    for (var i = 0; i < length; i++) {
      res.add(this[i]);
    }

    return res;
  }
}
