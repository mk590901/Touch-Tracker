import 'dart:math';
import 'dart:async';
import 'package:uuid/uuid.dart';
import 'taps.dart';

class Tap {
  final Point<double> _point;
  String _uuid = "";
  Taps? _parent;
  Timer? _timer;

  Tap(this._point) {
    Uuid uuid = const Uuid();
    _uuid = uuid.v1();
  }

  String uuid() {
    return _uuid;
  }

  void setParent(Taps parent) {
    _parent = parent;
  }

  void run() {
    Duration oneSec = const Duration(milliseconds: 2000);
    _timer = Timer.periodic(oneSec, (Timer t) {
      t.cancel();
      _parent?.update(_uuid);
    });
  }

  void stop() {
    if (_timer != null
    &&  _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = null;
  }

  Point<double> point() {
    return _point;
  }
}
