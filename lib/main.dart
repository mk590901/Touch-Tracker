import 'package:flutter/material.dart';

import 'gesture/gesture_manager.dart';
import 'ui/drawing_widget.dart';

void main() {
  GestureManager.initInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainAppPage()
    );
  }
}

class MainAppPage extends StatelessWidget {
  MainAppPage({super.key});

  final DrawingWidget drawingWidget = DrawingWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main App Page'),
      ),
      body: drawingWidget,
    );
  }
}

