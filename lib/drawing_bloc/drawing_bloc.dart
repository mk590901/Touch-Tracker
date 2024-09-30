import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../gesture/gesture_type.dart';
import '../helpers/tap.dart';
import '../helpers/taps.dart';
import 'drawing_events.dart';
import 'scene_state.dart';

class DrawingBloc extends Bloc<DrawingEvent, SceneState> {

  late int seqNumber = 0;

  DrawingBloc() : super (SceneState(points: const <Offset?>[],
      color: Colors.lightBlue, lineWidth: 1.0, sequentialNumber: 0, gestureType: 0,
      taps: Taps(), longPresses: Taps(),
      )) {

    on<StartDrawing>((event, emit) {
      final updatedPoints = List<Offset?>.from(state.points)
        ..add(event.point);
      emit(SceneState(points: updatedPoints, color: state.color, lineWidth: state.lineWidth,
        gestureType: state.gestureType, sequentialNumber: seqNumber++,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<AddPoint>((event, emit) {
      //  Need pay attention on event.point
      final updatedPoints = List<Offset?>.from(state.points)..add(event.point);
      emit(SceneState(points: updatedPoints, color: state.color, lineWidth: state.lineWidth,
        gestureType: state.gestureType, sequentialNumber: seqNumber++,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<FinalDrawing>((event, emit) {
      seqNumber = 0;
      final updatedPoints = List<Offset?>.from(state.points)..add(null);
      emit(SceneState(points: updatedPoints, color: state.color, lineWidth: state.lineWidth,
        gestureType: state.gestureType, sequentialNumber: seqNumber,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<ClearDrawing>((event, emit) {
      emit(SceneState(points: const [], color: state.color, lineWidth: state.lineWidth,
        gestureType: state.gestureType, sequentialNumber: state.sequentialNumber,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<ChangeColor>((event, emit) {
      emit(SceneState(points: state.points, color: event.color, lineWidth: state.lineWidth,
        gestureType: state.gestureType, sequentialNumber: state.sequentialNumber,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<ChangeLineWidth>((event, emit) {
      emit(SceneState(points: state.points, color: state.color, lineWidth: event.lineWidth,
        gestureType: state.gestureType, sequentialNumber: state.sequentialNumber,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<Refresh>((event, emit) {
      emit(SceneState(points: state.points, color: state.color, lineWidth: state.lineWidth,
        gestureType: state.gestureType, sequentialNumber: seqNumber++,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<ChangeGestureType>((event, emit) {
      /// A little clarification: if the event brings GestureType.NONE,
      /// the taps and longPress containers in state are checked.
      /// If they are empty, currentGestureType is set to GestureType.NONE,
      /// otherwise currentGestureType remains the same as state.gestureType.
      /// This allows us to solve the following problem: the tap points will
      /// be drawn in any case, but the gesture type label will change or
      /// disappear only when the taps and longPress containers are empty.
      int currentGestureType = event.gestureType;

      debugPrint('currentGestureType->$currentGestureType');

      Taps? updatedTaps;
      if (event.gestureType == GestureType.TAP_.index) {
        updatedTaps = state.taps;
        updatedTaps.put(Tap(event.point));
      } else if (event.gestureType == GestureType.LONGPRESS_.index) {
        updatedTaps = state.longPresses;
        updatedTaps.put(Tap(event.point));
      } else if (event.gestureType == GestureType.NONE_.index) {
        if (state.taps.container().isNotEmpty ||
            state.longPresses.container().isNotEmpty) {
          currentGestureType = state.gestureType;
        }
      }
      emit(SceneState(
        points: state.points,
        color: state.color,
        lineWidth: state.lineWidth,
        gestureType: currentGestureType,
        sequentialNumber: seqNumber++,
        taps: (event.gestureType == GestureType.TAP_.index)
            ? updatedTaps ?? state.taps
            : state.taps,
        longPresses: (event.gestureType == GestureType.LONGPRESS_.index)
            ? updatedTaps ?? state.longPresses
            : state.longPresses,
      ));
    });
  }


}
