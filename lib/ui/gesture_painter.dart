import 'dart:math';

import 'package:flutter/material.dart';

import '../gesture/gesture_type.dart';
import '../helpers/pair.dart';
import '../helpers/taps.dart';
import '../q_interfaces/typedefs.dart';
// import '../../components/application/application_holder.dart';
// import '../../components/gesture/gesture_type.dart';
// import '../../components/text_style/text_style_helper.dart';
// import '../../hsm_editor/Editor.dart';
// import '../../hsm_editor/graphicInterfaces/IPainter.dart';
// import '../../hsm_editor/graphicInterfaces/IShape.dart';
// import '../../hsm_editor/graphicPrimitives/CellWrapper.dart';
// import '../../hsm_editor/scene/scene_entity.dart';
// import '../../components/helpers/taps.dart';
// import '../../core/callback_fun_type.dart';
// import '../../ui_skeleton/pair.dart';
// import '../utils_functions.dart';

class GesturePainter extends CustomPainter /*implements IPainter*/ {
  final List<Offset?> points;
  final Color color;
  final Color canvasColor;
  final double lineWidth;
  final double zoomLevel;
  final bool gridMode;
  final Pair<int,int> offset;
  final int gridsNumber;
  final int gestureType;
  final Taps taps;
  final Taps longPresses;
  final VoidCallbackParameter? callback;

  final double pointGridRadius = 2.0;
  late double pointRadius = 4.0; //8.0;

  final boxPaint = Paint()
    ..color = Colors.lightBlue
    ..style = PaintingStyle.fill;

  final paintTap = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  final paintLong = Paint()
    ..color = Colors.redAccent
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  final tapRadius = 24.0;
  final longRadius = 32.0;

  late Paint paintRawPoints;
  late Paint paintCanvas;

  GesturePainter(this.points, this.canvasColor, this.color, this.lineWidth, this.zoomLevel, this.gridMode,
      this.offset, this.gridsNumber, this.gestureType, this.taps, this.longPresses, this.callback) {

    taps.setCallback(callback);
    longPresses.setCallback(callback);

    paintRawPoints = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = lineWidth;

    paintCanvas = Paint()
      ..color = canvasColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.fill;

  }

  @override
  void paint (Canvas canvas, Size size) {

    callback?.call(size);

    drawBackground(canvas, size);
    drawRawPoints(canvas, size);
    drawTaps(canvas);
    drawLongPresses(canvas);
    if (GestureType.values[gestureType] != GestureType.NONE_) {
      drawGestureType(canvas, size, gestureType);
    }
  }

  void drawRawPoints(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        Offset from = points[i]!;
        Offset to = points[i + 1]!;
        canvas.drawLine(from, to, paintRawPoints);  // with zoom
      }
    }
  }

  void drawGestureType(Canvas canvas, Size size, int gestureType) {
    final rect = Rect.fromLTWH(size.width*0.75, 4, size.width*0.24, size.height/22);
    final radiusRect = RRect.fromRectAndRadius(rect, const Radius.circular(16));

    canvas.drawRRect(radiusRect, boxPaint);

    TextSpan textSpan = TextSpan(
      text: getGestureType(gestureType), //'$gestureType', //'none',
      style: const TextStyle(color: Colors.white, fontSize: 12),
    );

    // Use TextPainter to draw the text
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Layout the text within the given constraints
    textPainter.layout(minWidth: 0, maxWidth: size.width*0.20);

    // Calculate the position to center the text in the box
    final offset = Offset(
        (size.width - textPainter.width) / 2 + size.width * 0.37, //size.width * 0.87,
        4 + (size.height/22 - textPainter.height) / 2,
    );

    // Paint the text on the canvas
    textPainter.paint(canvas, offset);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  String getGestureType(int gestureType) {
    return  GestureType.values[gestureType].name;
  }

  void drawTaps(Canvas canvas) {
     drawTapsContainer(canvas, taps, paintTap);
  }

  void drawLongPresses(Canvas canvas) {
    drawTapsContainer(canvas, longPresses, paintLong);
  }

  void drawTapsContainer(Canvas canvas, Taps taps, Paint paint) {
    if (taps.container().isEmpty) {
      return;
    }

    taps.container().forEach((k, tap) {
      Point<double> point = tap.point();
      canvas.drawCircle(Offset(point.x, point.y), tapRadius, paint);
    });
  }

  void drawBackground(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromPoints(const Offset(0, 0),
            Offset(size.width, size.height)),
        paintCanvas);
  }

}
