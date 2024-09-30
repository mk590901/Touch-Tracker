import 'dart:math';
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
  void onTap(int pointer, Point<double> point) {
    _state?.updateAndReset(GestureType.TAP_, point);
  }

}