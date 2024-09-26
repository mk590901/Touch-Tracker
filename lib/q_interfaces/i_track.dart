import 'dart:ui';

import 'i_gesture_listener.dart';

abstract class ITrack {
  void onTryToRecognizeGesture(
      int pointer, Offset point, IGestureListener gesture);
  bool isMoveMode();
  void setMoveMode(bool enable);
}
