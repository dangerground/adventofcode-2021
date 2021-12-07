

Iterable<int> range(int minPos, int maxPos) =>
    Iterable.generate(minPos + maxPos)..skip(minPos);