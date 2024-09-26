import 'dart:math';

class Points {
  final Map<int, List<Point<double>>> _container = <int, List<Point<double>>>{};

  void clear() {
    _container.clear();
  }

  void put(int pointer, Point<double> point) {
    List<Point<double>>? points = _container[pointer];
    if (points != null) {
      points.add(Point<double>(point.x, point.y));
    }
    //print ('Points.put->${points.length}');
  }

  void register(int pointer, Point<double> point) {
    if (_container.containsKey(pointer)) {
      remove(pointer);
    }
    List<Point<double>> points = [];
    points.add(Point<double>(point.x, point.y));
    _container[pointer] = points;
  }

  void remove(int pointer) {
    _container.remove(pointer);
  }

  List<Point<double>>? points(int pointer) {
    return _container[pointer];
  }

  bool isEmpty() {
    return _container.isEmpty ? true : false;
  }

  Map<int, List<Point<double>>> container() {
    return _container;
  }
}
