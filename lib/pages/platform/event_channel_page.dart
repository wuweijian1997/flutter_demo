import 'dart:ui';

import 'package:demo/platform/index.dart';
import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class EventChannelPage extends StatefulWidget {
  static const String rName = "EventChannel";

  @override
  _EventChannelPageState createState() => _EventChannelPageState();
}

class _EventChannelPageState extends State<EventChannelPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<int>(
          stream: DemoEventChannel.stream,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasError) {
              Log.info("error: ${snapshot.error}");
              return Text("Error");
            } else {
              return Text(
                '${snapshot.data}',
                style: TextStyle(fontSize: 50),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    DemoMethodChannel.startCountdown(100);
  }
}
