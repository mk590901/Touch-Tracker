import 'dart:ui';
import 'dart:math';

enum ActionModifier { Start, Final, Continue, Terminate }

abstract class IGestureListener {
  void onTap(int pointer, Point<double> point);
  void onLongPress(int pointer, Point<double> point);
  void onMove(int pointer, ActionModifier actionModifier, Point<double> point);
  void onPause(int pointer, Point<double> point);

  void onScroll(
      int pointer,
      ActionModifier actionModifier,
      List<Point<double>>? downPoints,
      List<Point<double>>? lastPoints,
      Offset offset);

  void onZoom(
      int pointer,
      ActionModifier actionModifier,
      List<Point<double>>? downPoints,
      List<Point<double>>? lastPoints,
      double parameter);

  void onRotate(
      int pointer,
      ActionModifier actionModifier,
      List<Point<double>>? downPoints,
      List<Point<double>>? lastPoints,
      double? parameter);
}
