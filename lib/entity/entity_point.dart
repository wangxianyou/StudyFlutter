import 'dart:math';

class MyPoint {
  int x;
  int y;
  String des;

  MyPoint(this.x, this.y, this.des);

  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'desc': des};

  MyPoint.fromJson(Map<String, dynamic> map)
      : x = map['x'],
        y = map['y'],
        des = map['desc'];

  @override
  String toString() {
    return "Point{x=$x, y=$y, desc=$des}";
  }
}
