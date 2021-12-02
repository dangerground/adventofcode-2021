enum Direction {
  forward,
  up,
  down,
}

extension DirectionName on Enum {
  String name() => toString().split('.')[1];
}

Direction parseDirection(String str) =>
    Direction.values.firstWhere((e) => e.name() == str);

class DirectionInstruction {
  final Direction direction;
  final int num;

  DirectionInstruction({required this.direction, required this.num});

  static DirectionInstruction parse(String str) {
    var parts = str.split(' ');
    var direction = parseDirection(parts[0]);
    var num = int.parse(parts[1]);

    return DirectionInstruction(direction: direction, num: num);
  }
}