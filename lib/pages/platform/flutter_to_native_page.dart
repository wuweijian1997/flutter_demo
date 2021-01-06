import 'package:demo/platform/index.dart';
import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class FlutterToNativePage extends StatefulWidget {
  static const String rName = "FlutterToNative";

  @override
  _FlutterToNativePageState createState() => _FlutterToNativePageState();
}

class _FlutterToNativePageState extends State<FlutterToNativePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$count',
          style: TextStyle(fontSize: 40),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          int _value = await CounterChannel.increment(count);
          Log.info("count: $_value");
          setState(() {
            count = _value;
          });
        },
      ),
    );
  }
}
