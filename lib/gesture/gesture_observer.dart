import 'dart:math';
import '../q_interfaces/i_gesture_listener.dart';
import '../q_interfaces/i_update.dart';
import 'gesture_type.dart';

class GestureObserver implements IGestureListener {
  final IUpdate? _widget;

  GestureObserver([this._widget]);

  @override
  void onLongPress(int pointer, Point<double> point) {
    _widget?.updateAndReset(GestureType.LONGPRESS_, point);
  }

  @override
  void onMove(int pointer, ActionModifier actionModifier, Point<double> point) {
    _widget?.updateMove(pointer, actionModifier, point);
    _widget?.update(actionModifier == ActionModifier.Final ? GestureType.NONE_ : GestureType.MOVE_);
  }

  @override
  void onPause(int pointer, Point<double> point) {
    _widget?.update(GestureType.PAUSE_);
  }

  @override
  void onTap(int pointer, Point<double> point) {
    _widget?.updateAndReset(GestureType.TAP_, point);
  }

}