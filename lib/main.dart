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
        title: //const Text('One Touch Tracker'),
        const Text('One Touch Tracker',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.italic,
              shadows: [
                Shadow(
                  blurRadius: 8.0,
                  color: Colors.indigo,
                  offset: Offset(3.0, 3.0),
                ),
              ],
            )),
        backgroundColor: Colors.lightBlue,
        leading: IconButton(onPressed: () {},
            icon: const Icon(Icons.draw_outlined, color: Colors.white)),
      ),
      body: drawingWidget,
    );
  }
}

