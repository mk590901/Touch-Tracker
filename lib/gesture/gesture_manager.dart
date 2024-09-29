import 'dart:math';
import 'dart:ui';

import '../q_hsm_track/track_context_object.dart';
import '../q_interfaces/i_gesture_listener.dart';
import '../q_support/object_event.dart';
import '../q_support/tracker.dart';
import 'gesture_listeners_container.dart';
import 'trackers_container.dart';

class GestureManager {
  static GestureManager? _instance;

//  State machine attributes
  //ILogger? logger;
  //ILogger? contextLogger;
  //Interceptor? interceptor;
  //GestureManagerContextObject? contextObject;
  //GestureManagerMediator? mediator;
  //GestureManagerQHsmScheme? scheme;
  //GestureHsmWrapper? schemeWrapper;

  final GestureListenersContiner _listeners = GestureListenersContiner();
  final TrackersContiner _container = TrackersContiner();

  static void initInstance() {
    _instance ??= GestureManager();
  }

  GestureManager() {
    _initStateMachine();
  }

  static GestureManager? manager() {
    if (_instance == null) {
      throw Exception("--- GestureManager was not initialized ---");
    }
    return _instance;
  }

  void register(int key, IGestureListener listener) {
    if (_listeners.contains(key)) {
      print ("GestureManager.register [$key] failed");
      return;
    }
    _listeners.register(key, listener);
    print("GestureManager.register [$key] registered");
  }

  void unregister(int key) {
    if (!_listeners.contains(key)) {
      print("GestureManager.unregister [$key] failed");
      return;
    }
    _listeners.unregister(key);
    print("GestureManager.unregister [$key] unregistered");
  }

  Map<int, Tracker> trackers() {
    return _container.trackers();
  }

  int listenersNumber() {
    return _listeners.size();
  }

  // void doSomething() {
  //   print("Do something...");
  // }

//  Main functions
  void onDown(int timeStampInMs, int key, Point<double> position) {
    if (_container.size() >= 2) {
      print("Failed to register->#2");
      _container.clear();
      //return;
    }
    _container.register(key, Tracker(key));
    Tracker? tracker = _container.get(key);
    if (tracker == null) {
      print("onDown: Failed to get tracker [$key]");
      return;
    }
    tracker.init(timeStampInMs, position.x, position.y);
    //  Operation for tracker's state machine
    tracker.done(ObjectEvent(
        TrackContextObject.TouchDown,
        Point<double>(
            position.x.round().toDouble(), position.y.round().toDouble())));
  }

  int numberTrackers() {
    return _container.size();
  }

  Tracker? tracker(int key) {
    return _container.get(key);
  }

  void onMove(int timeStampInMs, int key, Point<double> position) {
    Tracker? tracker = _container.get(key);
    if (tracker == null) {
      print("onMove: Failed to get tracker [$key]");
      return;
    }
    tracker.update(timeStampInMs, position.x, position.y);
    // contextObject?.done(ObjectEvent(
    //     GestureManagerContextObject.Move,
    //     PointExt(
    //         key,
    //         Point<double>(position.x.round().toDouble(),
    //             position.y.round().toDouble()))));



//    tracker.done(new ObjectEvent(GestureManagerContextObject.TouchMove,
//        new Point<double>(position.x.round().toDouble(), position.y.round().toDouble()))
//    );
  }

  void onUp(int timeStampInMs, int key, Point<double> point) {
    Tracker? tracker = _container.get(key);
    if (tracker == null) {
      print("onUp: Failed to get tracker [$key]");
      return;
    }

    tracker.done(ObjectEvent(TrackContextObject.TouchUp, point));


    // contextObject?.done(ObjectEvent(
    //     GestureManagerContextObject.Up,
    //     PointExt(
    //         key,
    //         Point<double>(position.x.round().toDouble(),
    //             position.y.round().toDouble()))));

    //  Error. this operation for tracker's state machine
//    tracker.done(new ObjectEvent(GestureManagerContextObject.TouchUp,
//        new Point<double>(position.x.round().toDouble(), position.y.round().toDouble()))
//    );
//    tracker.stop();
//    _container.unregister(key);
  }

  void _initStateMachine() {
    //logger = Logger();
    //contextLogger = Logger();
    //interceptor = Interceptor(logger!);
    // contextObject = GestureManagerContextObject(contextLogger);
    // mediator =
    //     GestureManagerMediator(contextObject!, interceptor!, contextLogger!);
    // scheme = GestureManagerQHsmScheme(mediator!);
    // schemeWrapper = GestureHsmWrapper(scheme!, mediator!);
    //
    // contextObject!.init();
  }

  void eventTap(int pointer, Point<double> point) {

    print('GestureManager.eventTap->[$pointer : $point]') ;

    Map<int,IGestureListener> map = _listeners.clone();
    map.forEach((k, listener) {
      listener.onTap(pointer, point);
    });

    _container.unregister(pointer);
    print('Tracker [$pointer] was unregistered');
  }

  void eventLongPress(int pointer, Point<double> point) {
    Map<int,IGestureListener> map = _listeners.clone();
    map.forEach((k, listener) {
      listener.onLongPress(pointer, point);
    });

    _container.unregister(pointer);
    print('Tracker [$pointer] was unregistered');
  }

  void eventMove(
    int pointer, ActionModifier actionModifier, Point<double> point) {
    //@print('eventMove->[$pointer]($actionModifier)[${point.x},${point.y}] _listeners#->${_listeners.size()}');
    Map<int,IGestureListener> map = _listeners.clone();
    map.forEach((k, listener) {
      listener.onMove(pointer, actionModifier, point);
    });

    if (actionModifier == ActionModifier.Final) {
      _container.unregister(pointer);
      print('Tracker [$pointer] was unregistered');
    }
  }

  void eventTerminateMove() {
    print("------- TERMINATE -------");
    Map<int, Tracker> tracks = _container.trackers();
    _listeners.listeners().forEach((k, listener) {
      tracks.forEach((pointer, tracker) {
        Point<double> lastPoint = tracker.contextObject.getLastPoint()!;
        listener.onMove(pointer, ActionModifier.Terminate, lastPoint);
        //tracker.done(new ObjectEvent(TrackContextObject.TouchMove, lastPoint)); //  ????
        //tracker.done(new ObjectEvent(TrackContextObject.Reset, lastPoint)); //  ????
      });
    });
    print("+++++++ TERMINATE +++++++");
  }

  void eventPause(int pointer, Point<double> point) {
    print('eventPause->[$pointer]($point)');
    Map<int,IGestureListener> map = _listeners.clone();
    map.forEach((k, listener) {
      listener.onPause(pointer, point);
    });
  }

  void eventScroll(
      int pointer,
      ActionModifier actionModifier,
      List<Point<double>>? downPoints,
      List<Point<double>>? lastPoints,
      Offset offset) {
    //print('eventScroll->[$pointer]($actionModifier)');
    _listeners.listeners().forEach((k, listener) {
      listener.onScroll(
          pointer, actionModifier, downPoints, lastPoints, offset);
    });

    if (actionModifier == ActionModifier.Final) {
//      _container.unregister(pointer);
//      print ('Tracker [$pointer] was unregistered');
      print('Scroll final: all trackers are unregistered');
      _container.clear();
    }
  }

  void eventZoom(
      int pointer,
      ActionModifier actionModifier,
      List<Point<double>>? downPoints,
      List<Point<double>>? lastPoints,
      double parameter) {
      print('eventZoom->[$pointer]($actionModifier) _listeners#->${_listeners.size()}, parameter->$parameter');
      _listeners.listeners().forEach((k, listener) {
          listener.onZoom(
            pointer, actionModifier, downPoints, lastPoints, parameter);
    });

    if (actionModifier == ActionModifier.Final) {
//      _container.unregister(pointer);
//      print ('Tracker [$pointer] was unregistered');
      print('Zoom final: all trackers are unregistered');
      _container.clear();
    }
  }

  void eventRotate(
      int pointer,
      ActionModifier actionModifier,
      List<Point<double>>? downPoints,
      List<Point<double>>? lastPoints,
      double? parameter) {
    //print('eventRotate->[$pointer]($actionModifier)');
    _listeners.listeners().forEach((k, listener) {
      listener.onRotate(
          pointer, actionModifier, downPoints, lastPoints, parameter);
    });

    if (actionModifier == ActionModifier.Final) {
//      _container.unregister(pointer);
//      print ('Tracker [$pointer] was unregistered');
      print('Rotate final: all trackers are unregistered');
      _container.clear(); //  unregister all trackers
    }
  }
}
