import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// DrawingEvent
abstract class DrawingEvent extends Equatable {
  const DrawingEvent();
}

class AddPoint extends DrawingEvent {
  final Offset point;

  const AddPoint(this.point);

  @override
  List<Object> get props => [point];
}

class StartDrawing extends DrawingEvent {
  final Offset point;

  const StartDrawing(this.point);

  @override
  List<Object> get props => [point];
}

class FinalDrawing extends DrawingEvent {
  @override
  List<Object> get props => [];
}

class ClearDrawing extends DrawingEvent {
  @override
  List<Object> get props => [];
}

class ChangeColor extends DrawingEvent {
  final Color color;
  const ChangeColor(this.color);

  @override
  List<Object> get props => [color];
}

class ChangeLineWidth extends DrawingEvent {
  final double lineWidth;
  const ChangeLineWidth(this.lineWidth);

  @override
  List<Object> get props => [lineWidth];
}

class ChangeGridMode extends DrawingEvent {
  final bool gridMode;
  const ChangeGridMode(this.gridMode);

  @override
  List<Object> get props => [gridMode];
}

class ChangeZoom extends DrawingEvent {
  final double zoomLevel;
  const ChangeZoom(this.zoomLevel);

  @override
  List<Object> get props => [zoomLevel];
}

class ChangeGestureType extends DrawingEvent {
  final int gestureType;
  final Point<double> point;
  const ChangeGestureType(this.gestureType, this.point);

  @override
  List<Object> get props => [gestureType, point];
}

class Refresh extends DrawingEvent {
  @override
  List<Object> get props => [];
}
