
import 'dart:math';
import '../q_hsm_track/track_context_object.dart';
import '../q_hsm_track/track_hsm_wrapper.dart';
import '../q_hsm_track/track_mediator.dart';
import '../q_hsm_track/track_qhsm_scheme.dart';
import '../q_interfaces/i_gesture_listener.dart';
import '../q_interfaces/i_logger.dart';
import 'interceptor.dart';
import 'logger.dart';
import 'object_event.dart';

class Tracker {
  ILogger?             logger;
  ILogger?             contextLogger;
  Interceptor?         interceptor;
  late TrackContextObject  contextObject;
  TrackMediator?       mediator;
  TrackQHsmScheme?     scheme;
  TrackHsmWrapper?     schemeWrapper;
  IGestureListener?    gesture;
  final int           _pointer;
  Point<double>?      _currentPoint;

  Tracker(this._pointer) {
    logger        = Logger();
    contextLogger = Logger();
    interceptor   = Interceptor();
    contextObject = TrackContextObject(_pointer, contextLogger);
    mediator      = TrackMediator(contextObject, interceptor!, contextLogger!);
    scheme        = TrackQHsmScheme(mediator!);
    schemeWrapper = TrackHsmWrapper(scheme!, mediator!);

    contextObject.init();

  }

  void done(ObjectEvent event) {
    //print ('tracker done ${event.event()} : ${event.data()}');
    contextObject.done(event);
  }

  void init(int time, double x, double y) {
    contextObject.moveInit(time, x, y);
  }

  void update(int time, double x, double y) {
    contextObject.moveDone(time, x, y, this);
  }

  void stop() {
    contextObject.moveStop();
  }

  void setCurrentPoint(Point<double> point) {
    _currentPoint = point;
  }

  Point<double>? getCurrentPoint() {
    return _currentPoint;
  }

}