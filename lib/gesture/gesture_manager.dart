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

  final GestureListenersContiner _listeners = GestureListenersContiner();
  final TrackersContiner _container = TrackersContiner();

  static void initInstance() {
    _instance ??= GestureManager();
  }

  GestureManager();

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

  void onMove(int timeStampInMs, int key, Point<double> point) {
    Tracker? tracker = _container.get(key);
    if (tracker == null) {
      print("onMove: Failed to get tracker [$key]");
      return;
    }
    tracker.update(timeStampInMs, point.x, point.y);
    tracker.done(ObjectEvent(TrackContextObject.TouchMove, point));
  }

  void onUp(int timeStampInMs, int key, Point<double> point) {
    Tracker? tracker = _container.get(key);
    if (tracker == null) {
      print("onUp: Failed to get tracker [$key]");
      return;
    }
    tracker.done(ObjectEvent(TrackContextObject.TouchUp, point));
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

  void eventPause(int pointer, Point<double> point) {
    print('eventPause->[$pointer]($point)');
    Map<int,IGestureListener> map = _listeners.clone();
    map.forEach((k, listener) {
      listener.onPause(pointer, point);
    });
  }
}
