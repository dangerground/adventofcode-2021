import 'dart:math' as math;

extension IntIterable on Iterable<int> {
  max() {
    return reduce((acc, val) => math.max(acc, val));
  }

  min() {
    return reduce((acc, val) => math.min(acc, val));
  }
}
