import 'package:flutter/material.dart';
import 'dart:math';
import '../gesture/gesture_type.dart';
import 'i_gesture_listener.dart';

abstract class IUpdate {
  void  update          (GestureType type, [Object? object]);
  void  updateAndReset  (GestureType type, [Object? object]);
  void  updateMove      (int pointer, ActionModifier actionModifier, Point<double> point);
}
