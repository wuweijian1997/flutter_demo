import 'package:demo/platform/index.dart';
import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class MethodChannelPage extends StatefulWidget {
  static const String rName = "MethodChannel";

  @override
  _MethodChannelPageState createState() => _MethodChannelPageState();
}

class _MethodChannelPageState extends State<MethodChannelPage> {
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
          int _value = await DemoMethodChannel.increment(count);
          Log.info("count: $_value");
          setState(() {
            count = _value;
          });
        },
      ),
    );
  }
}
