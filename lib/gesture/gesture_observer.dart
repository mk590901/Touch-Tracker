import 'dart:math';
import 'dart:ui';
import '../q_interfaces/i_gesture_listener.dart';
import '../q_interfaces/i_update.dart';
import 'gesture_type.dart';

class GestureObserver implements IGestureListener {
  final IUpdate? _state;

  GestureObserver([this._state]);

  @override
  void onLongPress(int pointer, Point<double> point) {
    _state?.updateAndReset(GestureType.LONGPRESS_, point);
  }

  @override
  void onMove(int pointer, ActionModifier actionModifier, Point<double> point) {
    _state?.updateMove(pointer, actionModifier, point);
    _state?.update(actionModifier == ActionModifier.Final ? GestureType.NONE_ : GestureType.MOVE_);
  }

  @override
  void onPause(int pointer, Point<double> point) {
    _state?.update(GestureType.PAUSE_);
  }

  @override
  void onRotate(int pointer, ActionModifier actionModifier, List<Point<double>>? downPoints, List<Point<double>>? lastPoints, double? parameter) {
    _state?.update(actionModifier == ActionModifier.Final ? GestureType.NONE_ : GestureType.ROTATION_, parameter);
  }

  @override
  void onScroll(int pointer, ActionModifier actionModifier, List<Point<double>>? downPoints, List<Point<double>>? lastPoints, Offset offset) {
    _state?.update(actionModifier == ActionModifier.Final ? GestureType.NONE_ : GestureType.SCROLL_, offset);
    _state?.updateScroll(actionModifier, offset);
  }

  @override
  void onTap(int pointer, Point<double> point) {
    _state?.updateAndReset(GestureType.TAP_, point);
  }

  @override
  void onZoom(int pointer, ActionModifier actionModifier, List<Point<double>>? downPoints, List<Point<double>>? lastPoints, double parameter) {
    _state?.update(actionModifier == ActionModifier.Final ? GestureType.NONE_ : GestureType.ZOOM_, parameter);
    _state?.updateZoom(actionModifier, parameter);
  }
}