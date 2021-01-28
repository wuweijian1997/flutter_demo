import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

class ListViewPage extends StatefulWidget {
  static final String rName = "ListView";

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 200,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _CountdownDemo(endTime);
          } else {
            return Container(
              height: 200,
              color: Colors.blue,
              margin: EdgeInsets.all(10),
            );
          }
        },
      ),
    );
  }
}

class _CountdownDemo extends StatefulWidget {
  final int endTime;

  _CountdownDemo(this.endTime);

  @override
  __CountdownDemoState createState() => __CountdownDemoState();
}

class __CountdownDemoState extends State<_CountdownDemo> {
  CountdownTimerController countdownTimerController;

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      controller: countdownTimerController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    Log.info("CountdownDemo dispose", StackTrace.current);
  }

  @override
  void initState() {
    super.initState();
    countdownTimerController =
        CountdownTimerController(endTime: widget.endTime);
    Log.info("CountdownDemo initState", StackTrace.current);
  }

  @override
  void didUpdateWidget(covariant _CountdownDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    Log.info("CountdownDemo didUpdateWidget", StackTrace.current);
  }
}
