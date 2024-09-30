import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../helpers/pair.dart';
import '../helpers/taps.dart';

class SceneState extends Equatable {
  final List<Offset?> points;
  final Color color;
  final double lineWidth;
  //final double zoomLevel;
  //final bool gridMode;
  //final Pair<int,int> offset;
  //final int gridsNumber;
  final int sequentialNumber;
  final int gestureType;
  final Taps taps;
  final Taps longPresses;

  const SceneState({required this.points, required this.color,
    required this.lineWidth, /*required this.zoomLevel, required this.gridMode,
    required this.offset, required this.gridsNumber,*/ required this.sequentialNumber,
    required this.gestureType, required this.taps, required this.longPresses});

  @override
  List<Object?> get props => [points, color, lineWidth, /*zoomLevel, gridMode, offset, gridsNumber,*/ sequentialNumber, gestureType, taps, longPresses];
}