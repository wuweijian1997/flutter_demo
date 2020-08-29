import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class CountdownTimerPage extends StatefulWidget {
  static const rName = 'CountdownTimer';

  @override
  _CountdownTimerPageState createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CountdownTimer(
            endTime: 1598769386983,
          ),
        ),
      ),
    );
  }
}
