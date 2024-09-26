enum GestureType {
  NONE_,
  TAP_,
  LONGPRESS_,
  PAUSE_,
  MOVE_,
  SCROLL_,
  ROTATION_,
  ZOOM_
}

extension GestureTypeName on GestureType {
  String get name {
    switch (this) {
      case GestureType.NONE_:
        return "none";
      case GestureType.TAP_:
        return "tap";
      case GestureType.LONGPRESS_:
        return "long press";
      case GestureType.PAUSE_:
        return "pause";
      case GestureType.MOVE_:
        return "move";
      case GestureType.SCROLL_:
        return "scroll";
      case GestureType.ROTATION_:
        return "rotation";
      case GestureType.ZOOM_:
        return "zoom";
      default:
        return "Unknown";
    }
  }
}
