// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:touch_track/gesture/gesture_manager.dart';
import 'package:touch_track/q_support/tracker.dart';
import 'mock_widget.dart';

void main() {

  GestureManager .initInstance();

  test('widget registration', () {
    expect(0, GestureManager.manager()?.listenersNumber());
    MockWidget widget = MockWidget();
    expect(1,GestureManager.manager()?.listenersNumber());
    widget.unregister();
    expect(0, GestureManager.manager()?.listenersNumber());
  });

  test('widget actions long press', () async {
    MockWidget widget = MockWidget();

  //  Touch down -> register & touch down
    widget.onDown(123450, const Point<double>(10,10));

    Tracker? tracker = GestureManager.manager()?.tracker(1);
    expect(tracker, isNotNull);

    await Future.delayed(const Duration(seconds: 2));

    tracker = GestureManager.manager()?.tracker(1);
    expect(tracker, isNull);

  });

  test('widget actions tap', () async {
    MockWidget widget = MockWidget();

    //  Touch down -> register & touch down
    widget.onDown(123450, const Point<double>(10,10));

    Tracker? tracker = GestureManager.manager()?.tracker(1);
    expect(tracker, isNotNull);

    widget.onUp(123453, const Point<double>(12,12));

    await Future.delayed(const Duration(seconds: 2));

    tracker = GestureManager.manager()?.tracker(1);
    expect(tracker, isNull);

  });


}
