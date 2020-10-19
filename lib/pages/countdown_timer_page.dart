import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CountdownTimerPage extends StatefulWidget {
  static const rName = 'CountdownTimer';

  @override
  _CountdownTimerPageState createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CountdownTimer(
          endTime: endTime,
        ),
      ),
    );
  }
}
