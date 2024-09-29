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

  final Paint paintLine = Paint()
    ..color = Colors.red[400]!.withAlpha(100)
    ..strokeWidth = 1.5
    ..style = PaintingStyle.stroke;

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

//  for IPainter  /////////////////////////////////////////////
  final paintCircle = Paint()
    ..color = Colors.deepPurpleAccent
    ..style = PaintingStyle.fill;

  final paintCircleSelected = Paint()
    ..color = Colors.deepPurple
    ..style = PaintingStyle.fill;

  final Paint enterStateRect = Paint()
    ..strokeWidth = 1.5
    //..color = Colors.redAccent[200]!.withAlpha(100)
    ..color = Colors.red[100]!.withAlpha(100)
    ..style = PaintingStyle.fill;

  final Paint eventStateRect = Paint()
    ..strokeWidth = 1.5
    ..color = Colors.orangeAccent[400]!.withAlpha(100)
    ..style = PaintingStyle.fill;

  final Paint initStateRect = Paint()
    ..strokeWidth = 1.5
    ..color = Colors.lightGreenAccent[200]!.withAlpha(100)
    ..style = PaintingStyle.fill;

  final Paint exitStateRect = Paint()
    ..strokeWidth = 1.5
    ..color = Colors.orangeAccent[100]!.withAlpha(100)
    ..style = PaintingStyle.fill;

  final Paint paintPath = Paint()
    ..strokeWidth = 1.5
    ..color = Colors.deepPurpleAccent //Colors.blue[500]
    ..style = PaintingStyle.stroke;

  final Paint paintPathError = Paint()
    ..strokeWidth = 1.5
    ..color = Colors.red
    ..style = PaintingStyle.stroke;

  final Paint paintRectBorder = Paint()
    ..strokeWidth = 1.5
    ..color = Colors.blue[800]!
    ..style = PaintingStyle.stroke;

  final Paint paintRectBorderError = Paint()
    ..strokeWidth = 1.5
    ..color = Colors.red
    ..style = PaintingStyle.stroke;

  final Paint paintRectBorderSelectedError = Paint()
    ..strokeWidth = 2.5
    ..color = Colors.redAccent
    ..style = PaintingStyle.stroke;

  final Paint paintRectBorderSelected = Paint()
    ..strokeWidth = 2.5
    ..color = Colors.blue[900]!
    ..style = PaintingStyle.stroke;

  final Paint paintRect = Paint()
    ..strokeWidth = 1.5
    ..color = Colors.blue[500]!.withAlpha(150)
    ..style = PaintingStyle.fill;

  final tapRadius = 24.0;
  final longRadius = 32.0;

  late Paint paintRawPoints;
  late Paint paintCanvas;
  late double stepSize;
  late double gridSize;

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

    debugPrint('GesturePainter.c.offset->[$offset],zoom->[$zoomLevel],gridsNumber->[$gridsNumber]');
  }

  @override
  void paint (Canvas canvas, Size size) {

    callback?.call(size);

  /////////////////////////////////////////////////////////////////
  //   Editor? editor = ApplicationHolder.holder()?.editor;
  //   Scene? scene = editor?.scene();
  //   scene?.updateCanvasProperties(size.width, size.height, gridsNumber/zoomLevel, offset);
  //   editor?.setCellWrapper(CellWrapper(scene));
  /////////////////////////////////////////////////////////////////

    gridSize = gridsNumber / zoomLevel;
    stepSize = size.width / gridSize;

    pointRadius = stepSize/4;

    //TextStyleHelper.textStyleHelperHelper()?.updateFontSize(stepSize);

    drawBackground(canvas, size);
    // drawGrid(canvas, size);
    // drawRawPoints(canvas, size);
    // drawShapes(canvas);
      drawTaps(canvas);
    // drawLongPresses(canvas);
    if (GestureType.values[gestureType] != GestureType.NONE_) {
      drawGestureType(canvas, size, gestureType);
    }
  }

  // void drawGrid(Canvas canvas, Size size) {
  //   if (!gridMode) {
  //     return;
  //   }
  //   int numberVertLines = (size.height / stepSize).floor();
  //   for (int i = 0; i < gridSize + 1; i++) {
  //     double horizontalShift = i.toDouble() * stepSize;
  //     for (int j = 0; j < numberVertLines + 1; j++) {
  //       double verticalShift = j.toDouble() * stepSize;
  //       canvas.drawCircle(
  //           Offset(horizontalShift, verticalShift), pointGridRadius, paintLine);
  //     }
  //   }
  // }

  // void drawRawPoints(Canvas canvas, Size size) {
  //
  //   Editor? editor = ApplicationHolder.holder()?.editor;
  //   Scene? scene = editor?.scene();
  //   if (scene == null) {
  //     return;
  //   }
  //
  //   double dx = scene.getScrollX();
  //   double dy = scene.getScrollY();
  //   double stepSize = scene.getStepSize();
  //
  //   double horizontalShift = - (stepSize * dx) * 2;
  //   double verticalShift = - (stepSize * dy) * 2;
  //
  //   //debugPrint('shift->[${horizontalShift.toStringAsFixed(1)},${verticalShift.toStringAsFixed(1)}]');
  //
  //   for (int i = 0; i < points.length - 1; i++) {
  //     if (points[i] != null && points[i + 1] != null) {
  //       Offset from_ = points[i]!*zoomLevel;
  //       Offset from = Offset(from_.dx - horizontalShift, from_.dy - verticalShift);
  //       Offset to_ = points[i + 1]!*zoomLevel;
  //       Offset to = Offset(to_.dx - horizontalShift, to_.dy - verticalShift);
  //       canvas.drawLine(from, to, paintRawPoints);  // with zoom
  //
  //       //debugPrint('[${from.dx.toStringAsFixed(1)},${from.dy.toStringAsFixed(1)}]->[${to.dx.toStringAsFixed(1)},${to.dy.toStringAsFixed(1)}]');
  //     }
  //   }
  // }

  // void drawRawPoints(Canvas canvas, Size size) {
  //
  //   //@debugPrint('drawRawPoints.offset->[$offset]');
  //
  //   double gridSize = gridsNumber / zoomLevel;
  //   double stepSize = size.width / gridSize;
  //   double horizontalShift = -(stepSize * offset.first());
  //   double verticalShift = -(stepSize * offset.second());
  //
  //   for (int i = 0; i < points.length - 1; i++) {
  //     if (points[i] != null && points[i + 1] != null) {
  //       Offset from_ = points[i]!*zoomLevel;
  //       Offset from = Offset(from_.dx - horizontalShift, from_.dy - verticalShift);
  //       Offset to_ = points[i + 1]!*zoomLevel;
  //       Offset to = Offset(to_.dx - horizontalShift, to_.dy - verticalShift);
  //       canvas.drawLine(from, to, paintRawPoints);  // with zoom
  //     }
  //   }
  // }

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
    //@debugPrint('drawTaps->${taps.container().length}');
    drawTapsContainer(canvas, taps, paintTap);
  }

  void drawLongPresses(Canvas canvas) {
    //@debugPrint('drawLongPresses->${longPresses.container().length}');
    drawTapsContainer(canvas, longPresses, paintLong);
  }

  void drawTapsContainer(Canvas canvas, Taps taps, Paint paint) {
    if (taps.container().isEmpty) {
      return;
    }

    // Editor? editor = ApplicationHolder.holder()?.editor;
    // Scene? scene = editor?.scene();
    double horizontalShift = 0;
    double verticalShift = 0;
    // if (scene != null) {
    //   double dx = scene.getScrollX();
    //   double dy = scene.getScrollY();
    //   double stepSize = scene.getStepSize();
    //   horizontalShift = -(stepSize * dx);
    //   verticalShift = -(stepSize * dy);
    // }

    taps.container().forEach((k, tap) {
      Point<double> point = tap.point();
      canvas.drawCircle(Offset(point.x - horizontalShift, point.y - verticalShift), tapRadius, paint);
    });
  }

  // void drawShapes(Canvas canvas) {
  //   drawRoutes(canvas);
  //   drawRectangles(canvas);
  // }

  // void drawRoutes(Canvas canvas) {
  //   Editor? editor = ApplicationHolder.holder()?.editor;
  //   Scene? scene = editor?.scene();
  //
  //   List<IShape>? routes = scene?.getShapes()?.getRoutes();
  //   if (routes == null || routes.isEmpty) {
  //     debugPrint('drawRoutes.(routes == null || routes.isEmpty)');
  //     return;
  //   }
  //
  //   double dx = 0;
  //   double dy = 0;
  //
  //   if (scene != null) {
  //     dx = scene.getScrollX();
  //     dy = scene.getScrollY();
  //   }
  //
  //   //@printRoutes('drawRoutes', dx, dy, stepSize, routes);
  //
  //   drawShapes2(canvas, scene, routes);
  // }
  //
  // void drawRectangles(Canvas canvas) {
  //   Editor? editor = ApplicationHolder.holder()?.editor;
  //   Scene? scene = editor?.scene();
  //   List<IShape>? rectangles = scene?.getShapes()?.getRectangles();
  //   if (rectangles == null || rectangles.isEmpty) {
  //     debugPrint('drawRectangles.(rectangles == null || rectangles.isEmpty)');
  //     return;
  //   }
  //
  //   double dx = 0;
  //   double dy = 0;
  //
  //   if (scene != null) {
  //     dx = scene.getScrollX();
  //     dy = scene.getScrollY();
  //   }
  //
  //   //printRectangles('drawRectangles', dx, dy, stepSize, rectangles);
  //
  //   drawShapes2(canvas, scene, rectangles);
  //
  // }
  //
  // void drawShapes2(Canvas canvas, Scene? scene, List<IShape> shapes) {
  //   for (int i = 0; i < shapes.length; i++) {
  //     IShape shape = shapes[i];
  //     if (shape == scene?.selectedShape) {
  //       shape.drawWithPainterSelected(
  //           canvas, this, scene!.getComputationGeometry()!, scene, stepSize);
  //     } else {
  //       shape.drawWithPainter(
  //           canvas, this, scene!.getComputationGeometry()!, scene, stepSize);
  //     }
  //   }
  // }

  // @override
  // Paint getDotCircle() {
  //   return paintCircle;
  // }
  //
  // @override
  // Paint getDotCircleSelected() {
  //   return paintCircleSelected;
  // }
  //
  // @override
  // Paint getEnterStateRect() {
  //   return enterStateRect;
  // }
  //
  // @override
  // Paint getEventStateRect() {
  //   return eventStateRect;
  // }
  //
  // @override
  // Paint getExitStateRect() {
  //   return exitStateRect;
  // }
  //
  // @override
  // Paint getInitStateRect() {
  //   return initStateRect;
  // }
  //
  // @override
  // Paint getPathPaint() {
  //   return paintPath;
  // }
  //
  // @override
  // Paint getPathPaintError() {
  //   return paintPathError;
  // }
  //
  // @override
  // double getPointRadius() {
  //   return pointRadius;
  // }
  //
  // @override
  // Paint getRectBorder() {
  //   return paintRectBorder;
  // }
  //
  // @override
  // Paint getRectBorderError() {
  //   return paintRectBorderError;
  // }
  //
  // @override
  // Paint getRectBorderSelected() {
  //   return paintRectBorderSelected;
  // }
  //
  // @override
  // Paint getRectBorderSelectedError() {
  //   return paintRectBorderSelectedError;
  // }
  //
  // @override
  // Paint getRectPaint() {
  //   return paintRect;
  // }

  void drawBackground(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromPoints(const Offset(0, 0),
            Offset(size.width, size.height)),
        paintCanvas);
  }

  // void update (dynamic parameter) {
  //   debugPrint('GesturePainter.update($parameter)');
  // }

}
