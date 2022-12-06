import 'dart:async';

import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class EventLoopPage extends StatefulWidget {
  static String rName = 'EventLoop';

  const EventLoopPage({Key? key}) : super(key: key);

  @override
  State<EventLoopPage> createState() => _EventLoopPageState();
}

class _EventLoopPageState extends State<EventLoopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Loop"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Future(() => Log.info("2222"));
          scheduleMicrotask(() {
            Log.info("333");
          });
          Log.info("111");
        },
      ),
    );
  }
}
