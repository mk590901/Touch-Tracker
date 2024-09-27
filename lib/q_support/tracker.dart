
import 'dart:math';
import '../q_hsm_track/track_context_object.dart';
import '../q_hsm_track/track_hsm_wrapper.dart';
import '../q_hsm_track/track_mediator.dart';
import '../q_hsm_track/track_qhsm_scheme.dart';
import '../q_interfaces/i_gesture_listener.dart';
import '../q_interfaces/i_logger.dart';
import 'Interceptor.dart';
import 'logger.dart';
import 'object_event.dart';

class Tracker {
  //GestureManager  _manager;

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
    interceptor   = Interceptor(logger!);
    contextObject = TrackContextObject(_pointer, contextLogger);
    mediator      = TrackMediator(contextObject, interceptor!, contextLogger!);
    scheme        = TrackQHsmScheme(mediator!);
    schemeWrapper = TrackHsmWrapper(scheme!, mediator!);

    contextObject.init();

  }

  void done(ObjectEvent event) {
    print ('tracker done ${event.event()} : ${event.data()}');
    contextObject.done(event);
  }

  void doneInside(ObjectEvent event) {
    contextObject.doneInside(event);
  }

  void init(int time, double x, double y) {
    print ('tracker init is done');
    contextObject.moveInit(time, x, y);
  }

  void update(int time, double x, double y) {
    print ('tracker update is done [$x,$y]');
    contextObject.moveDone(time, x, y, this);
  }

  void stop() {
    contextObject.moveStop();
    print ('tracker stop is done');
  }

  void setCurrentPoint(Point<double> point) {
    _currentPoint = point;
  }

  Point<double>? getCurrentPoint() {
    return _currentPoint;
  }

}