import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CustomDragGestureDetectorPage extends StatefulWidget {
  static String rName = "DragGesture";

  @override
  _CustomDragGestureDetectorPageState createState() =>
      _CustomDragGestureDetectorPageState();
}

class _CustomDragGestureDetectorPageState extends State<CustomDragGestureDetectorPage> {
  String text = '拖动:';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomDragGesture(
        onUpdate: (DragUpdateDetails details) {
          onDrag('red', details.localPosition);
        },
        log: 'RED',
        child: Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: CustomDragGesture(
            onUpdate: (DragUpdateDetails details) {
              onDrag('blue', details.localPosition);
            },
            disable: true,
            log: 'BLUE',
            child: Container(
              width: 300,
              height: 300,
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text(text),
            ),
          ),
        ),
      ),
    );
  }

  onDrag (String name, Offset location) {
    setState(() {
      text = '拖动: $name, offset: $location';
    });
  }
}
