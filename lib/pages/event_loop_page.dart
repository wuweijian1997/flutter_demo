import 'dart:async';

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
          Future(() => print("2222"));
          scheduleMicrotask(() {
            print("333");
          });
          print("111");
        },
      ),
    );
  }
}
