import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CustomGestureDetectorPage extends StatefulWidget {
  static String rName = "CustomGesture";

  @override
  _CustomGestureDetectorPageState createState() =>
      _CustomGestureDetectorPageState();
}

class _CustomGestureDetectorPageState extends State<CustomGestureDetectorPage> {
  String text = '点击:';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AllowMultipleGesture(
        onTap: () => onTap("red"),
        child: Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: AllowMultipleGesture(
            onTap: () => onTap("blue"),
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

  onTap (String name) {
    setState(() {
      text = '$text $name';
    });
  }
}
