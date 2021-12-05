class AccessMap {
  Map<int, Map<int, int>> content = <int, Map<int, int>>{};

  int _width = 0;
  int _height = 0;

  int get width => _width;

  int get height => _height;

/*
  import(String input) {
    var lines = input.split('\n');

    _height = lines.length;
    _width = lines[0].length;

    for (var y = 0; y < lines.length; y++) {
      for (var x = 0; x < lines[x].length; x++) {
        set(x, y, lines[x][y]);
      }
    }
  }

 */

  set(int x, int y, int entry) {
    if (x + 1 > _width) _width = x + 1;
    if (y + 1 > _height) _height = y + 1;

    if  (content[y] == null) {
      content[y] = <int, int>{};
      content[y]![x] = entry;
    }

    content[y]![x] = entry;
  }

  int? get(x, y) {
    return content[y]?[x];
  }

  @override
  String toString() {
    var result = "";
    for(var y = 0; y < _height; y++) {
      for (var x = 0; x < _width; x++) {
        var entry = get(x, y) ?? ".";
        result += "$entry";
      }
      result += "\n";
    }

    return result;
  }
}
