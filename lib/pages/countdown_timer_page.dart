import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CountdownTimerPage extends StatefulWidget {
  static const rName = 'CountdownTimer';

  @override
  _CountdownTimerPageState createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;
  CountdownTimerController countdownTimerController;

  @override
  void initState() {

    super.initState();
    countdownTimerController = CountdownTimerController(endTime: endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CountdownTimer(
          controller: countdownTimerController,
        ),
      ),
    );
  }
}
