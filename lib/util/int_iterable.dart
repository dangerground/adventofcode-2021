import 'dart:math' as math;

extension IntIterable on Iterable<int> {
  sum() {
    return reduce((acc, val) => acc + val);
  }

  max() {
    return reduce((acc, val) => math.max(acc, val));
  }

  min() {
    return reduce((acc, val) => math.min(acc, val));
  }
}
