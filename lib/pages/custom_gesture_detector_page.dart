import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CustomGestureDetectorPage extends StatefulWidget {
  static String rName = "Gesture";

  @override
  _CustomGestureDetectorPageState createState() =>
      _CustomGestureDetectorPageState();
}

class _CustomGestureDetectorPageState extends State<CustomGestureDetectorPage> {
  String text = '点击:';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTapGesture(
        onTap: () => onTap("red"),
        log: 'RED',
        child: Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: CustomTapGesture(
            onTap: () => onTap("blue"),
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

  onTap (String name) {
    setState(() {
      text = '$text $name';
    });
  }
}
