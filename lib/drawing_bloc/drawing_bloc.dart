import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../gesture/gesture_type.dart';
import '../helpers/pair.dart';
import '../helpers/tap.dart';
import '../helpers/taps.dart';
import 'drawing_events.dart';
import 'scene_state.dart';

class DrawingBloc extends Bloc<DrawingEvent, SceneState> {

  late int seqNumber = 0;

  DrawingBloc() : super (SceneState(points: const <Offset?>[],
      color: Colors.lightBlue, lineWidth: 1.0,
      /*zoomLevel: 1,
      gridMode:  false,
      offset:    Pair<int,int>(0,0),
      gridsNumber: 10,*/ sequentialNumber: 0, gestureType: 0,
      taps: Taps(), longPresses: Taps(),
      )) {

    on<StartDrawing>((event, emit) {
      final updatedPoints = List<Offset?>.from(state.points)
        ..add(event.point/* / state.zoomLevel*/);
      //putData('points', updatedPoints);
      emit(SceneState(points: updatedPoints, color: state.color, lineWidth: state.lineWidth,
      /*zoomLevel: state.zoomLevel, gridMode: state.gridMode, offset: state.offset,
        gridsNumber: state.gridsNumber,*/ gestureType: state.gestureType, sequentialNumber: seqNumber++,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<AddPoint>((event, emit) {
      //  Need pay attention on event.point / state.zoomLevel + or maybe - state.offset
      final updatedPoints = List<Offset?>.from(state.points)..add(event.point /*/ state.zoomLevel*/);
      //putData('points', updatedPoints);
      emit(SceneState(points: updatedPoints, color: state.color, lineWidth: state.lineWidth,
      /*zoomLevel: state.zoomLevel, gridMode: state.gridMode, offset: state.offset,
        gridsNumber: state.gridsNumber,*/ gestureType: state.gestureType, sequentialNumber: seqNumber++,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<FinalDrawing>((event, emit) {
      seqNumber = 0;
      final updatedPoints = List<Offset?>.from(state.points)..add(null);
      //putData('points', updatedPoints);
      emit(SceneState(points: updatedPoints, color: state.color, lineWidth: state.lineWidth,
      /*zoomLevel: state.zoomLevel, gridMode: state.gridMode, offset: state.offset,
        gridsNumber: state.gridsNumber,*/ gestureType: state.gestureType, sequentialNumber: seqNumber,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<ClearDrawing>((event, emit) {
      //putData('points', null);
      emit(SceneState(points: const [], color: state.color, lineWidth: state.lineWidth,
      /*zoomLevel: state.zoomLevel, gridMode: state.gridMode, offset: state.offset,
        gridsNumber: state.gridsNumber,*/ gestureType: state.gestureType, sequentialNumber: state.sequentialNumber,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<ChangeColor>((event, emit) {
      emit(SceneState(points: state.points, color: event.color, lineWidth: state.lineWidth,
      /*zoomLevel: state.zoomLevel, gridMode: state.gridMode, offset: state.offset,
        gridsNumber: state.gridsNumber,*/ gestureType: state.gestureType, sequentialNumber: state.sequentialNumber,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    on<ChangeLineWidth>((event, emit) {
      emit(SceneState(points: state.points, color: state.color, lineWidth: event.lineWidth,
      /*zoomLevel: state.zoomLevel, gridMode: state.gridMode, offset: state.offset,
        gridsNumber: state.gridsNumber,*/ gestureType: state.gestureType, sequentialNumber: state.sequentialNumber,
        taps: state.taps, longPresses: state.longPresses,
      ));
    });

    // on<ChangeGridMode>((event, emit) {
    //   //debugPrint('on<ChangeGridMode> [${event.gridMode}]');
    //   //putData('grids', event.gridMode);
    //   emit(SceneState(points: state.points, color: state.color, lineWidth: state.lineWidth,
    //   /*zoomLevel: state.zoomLevel, gridMode: event.gridMode, offset: state.offset,
    //     gridsNumber: state.gridsNumber,*/ gestureType: state.gestureType, sequentialNumber: state.sequentialNumber,
    //     taps: state.taps, longPresses: state.longPresses,
    //   ));
    // });
    //
    // on<ChangeZoom>((event, emit) {
    //   emit(SceneState(points: state.points, color: state.color, lineWidth: state.lineWidth,
    //       /*zoomLevel: event.zoomLevel, gridMode: state.gridMode, offset: state.offset,
    //     gridsNumber: state.gridsNumber,*/ gestureType: state.gestureType, sequentialNumber: state.sequentialNumber,
    //     taps: state.taps, longPresses: state.longPresses,
    //   ));
    // });

    on<Refresh>((event, emit) {
      emit(SceneState(points: state.points, color: state.color, lineWidth: state.lineWidth,
        /*zoomLevel: state.zoomLevel, gridMode: state.gridMode, offset: state.offset,
        gridsNumber: state.gridsNumber,*/ gestureType: state.gestureType, sequentialNumber: seqNumber++,
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
        // zoomLevel: state.zoomLevel,
        // gridMode: state.gridMode,
        // offset: state.offset,
        // gridsNumber: state.gridsNumber,
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
