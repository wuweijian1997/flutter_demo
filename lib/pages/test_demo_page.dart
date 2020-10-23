import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestDemo extends StatefulWidget {
  static const String rName = "TestDemo";
  @override
  State<StatefulWidget> createState() {
    return _TestDemoState();
  }
}

class _TestDemoState extends State<TestDemo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test Demo"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10,5,10,10),
              height: 100,
              color: Color(0xff1b8bdf),
            ),
            CountText(),
          ],
        )
    );
  }
}

class CountText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CountTextState();
  }
}

class _CountTextState extends State<CountText> {
  int _count = 0;
  Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (t) {
      setState(() {
        _count++;
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _count.toString(),
      style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold),
    );
  }
}