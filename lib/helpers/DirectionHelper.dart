import 'dart:ui';
import 'dart:math';
import 'shift_buffer.dart';

class DirectionHelper {
  final int _capacity;

  double _prevX = 0;
  double _prevY = 0;

  double _nextX = 0;
  double _nextY = 0;

  late ShiftBuffer<Offset> _shiftBuffer;

  DirectionHelper(this._capacity) {
    _shiftBuffer = ShiftBuffer<Offset>(_capacity);
  }

  void reset() {
    _prevX = 0;
    _prevY = 0;

    _nextX = 0;
    _nextY = 0;

    _shiftBuffer.reset();
  }

  void init(double x, double y) {
    _prevX = x;
    _prevY = y;
  }

  Offset direction(double x, double y) {
    Offset? vector;

    _nextX = x;
    _nextY = y;

    double dx = _nextX - _prevX;
    double dy = _nextY - _prevY;

    double ds = sqrt(dx * dx + dy * dy);

    if (ds == 0.0) return const Offset(0.0, 0.0);

    //  Normalization
    vector = Offset(dx / ds, dy / ds);

    _prevX = _nextX;
    _prevY = _nextY;

    _shiftBuffer.put(vector);

    return vector;
  }

  Offset? average() {
    Offset? v;
    double dx = 0;
    double dy = 0;
    int size = _shiftBuffer.size();
    if (size == 0) return v;
    for (int i = 0; i < size; i++) {
      Offset? value = _shiftBuffer.get(i);
      if (value != null) {
        dx += value.dx;
        dy += value.dy;
      }
    }
    v = Offset(dx / size.toDouble(), dy / size.toDouble());
    return v;
  }
}
