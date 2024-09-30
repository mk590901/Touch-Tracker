import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../drawing_bloc/drawing_bloc.dart';
import '../drawing_bloc/drawing_events.dart';
import '../drawing_bloc/scene_state.dart';
import '../gesture/gesture_manager.dart';
import '../gesture/gesture_observer.dart';
import '../gesture/gesture_type.dart';
import '../q_interfaces/i_gesture_listener.dart';
import '../q_interfaces/i_update.dart';
import '../q_interfaces/typedefs.dart';
import 'gesture_painter.dart';

class DrawingWidget extends StatelessWidget implements IUpdate {
  final DrawingBloc drawingBloc = DrawingBloc();
  late VoidCallbackParameter? callback;

  late Size screenSize = const Size(0, 0);

  DrawingWidget({super.key}) {
    GestureObserver client = GestureObserver(this);
    GestureManager.manager()?.register(1, client);
    callback = null;
    debugPrint('******* DrawingWidget.constructor *******');
  }

  void unregister() {
    GestureManager.manager()?.unregister(1);
  }

  void setCallBack(VoidCallbackParameter? callback) {
    this.callback = callback;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => drawingBloc,
      child: GestureDetector(
        onPanStart: (details) {
          Offset position = details.localPosition;
          double x = position.dx.round().toDouble();
          double y = position.dy.round().toDouble();
          GestureManager.manager()?.onDown(
              details.sourceTimeStamp!.inMilliseconds, 1, Point<double>(x, y));
        },
        onPanUpdate: (details) {
          Offset position = details.localPosition;
          double x = position.dx.round().toDouble();
          double y = position.dy.round().toDouble();
          GestureManager.manager()?.onMove(
              details.sourceTimeStamp!.inMilliseconds, 1, Point<double>(x, y));
        },
        onPanEnd: (details) {
          Offset position = details.localPosition;
          double x = position.dx.round().toDouble();
          double y = position.dy.round().toDouble();
          GestureManager.manager()?.onUp(0, 1, Point<double>(x, y));
        },

        child: BlocBuilder<DrawingBloc, SceneState>(
          builder: (context, state) {
            return CustomPaint(
              size: Size.infinite,
              painter: GesturePainter(
                  state.points,
                  Colors.lightBlue.shade200,
                  state.color,
                  state.lineWidth,
                  state.gestureType,
                  state.taps,
                  state.longPresses, (sizeParam) {
                if (sizeParam is Size) {
                  screenSize = sizeParam;
                } else {
                  debugPrint('******* DrawingWidget.update->[$sizeParam] *******');
                  update(GestureType.NONE_);
                }
              }),
            );
          },
        ),
      ),
    );
  }

  void clear() {
    drawingBloc.add(ClearDrawing());
  }

  void changeLineWidth(double lineWidth) {
    drawingBloc.add(ChangeLineWidth(lineWidth));
  }

  void changeColor(Color color) {
    drawingBloc.add(ChangeColor(color));
  }

  void refresh() {
    debugPrint('DrawingWidget.refresh');
    drawingBloc.add(Refresh());
  }

  @override
  void update(GestureType type, [Object? object]) {
    if (drawingBloc.isClosed) {
      return;
    }
    drawingBloc.add(ChangeGestureType(type.index, const Point<double>(-1, -1)));
  }

  @override
  void updateAndReset(GestureType type, [Object? object]) {
    debugPrint('IUpdate.updateAndReset: [$type]:$object');
    Point<double> point_ =
        (object ?? const Point<double>(0, 0)) as Point<double>;

    Point<double> point = Point(point_.x, point_.y);

    drawingBloc.add(ChangeGestureType(type.index, point));

    //  Processing...
    if (type == GestureType.TAP_) {
      debugPrint('GestureType.TAP_');
    }
  }

  @override
  void updateMove(
      int pointer, ActionModifier actionModifier, Point<double> point_) {

    Point<double> point = Point(point_.x, point_.y);

    debugPrint('updateMove [${point_.x.toStringAsFixed(1)},${point_.y.toStringAsFixed(1)}] [${point.x.toStringAsFixed(1)},${point.y.toStringAsFixed(1)}]');

    if (actionModifier == ActionModifier.Start) {
      drawingBloc.add(AddPoint(Offset(point.x, point.y)));

      debugPrint('ActionModifier.Start');

    }
    else
    if (actionModifier == ActionModifier.Continue) {
      drawingBloc.add(AddPoint(Offset(point.x, point.y)));

      debugPrint('ActionModifier.Continue');

    }
    else {
      if (actionModifier == ActionModifier.Terminate) {
        debugPrint('ActionModifier.Terminate');

      }
      drawingBloc.add(ClearDrawing());
    }
  }
}
