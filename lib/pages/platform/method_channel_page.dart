import 'package:demo/platform/index.dart';
import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelPage extends StatefulWidget {
  static const String rName = "MethodChannel";

  const MethodChannelPage({Key? key}) : super(key: key);

  @override
  _MethodChannelPageState createState() => _MethodChannelPageState();
}

class _MethodChannelPageState extends State<MethodChannelPage> {
  int count = 0;


  @override
  void initState() {
    super.initState();
    FlutterMethodChannel.methodChannel.setMethodCallHandler(decrement);
  }


  Future<dynamic> decrement(MethodCall call) async {
    Log.info("Android arguments: ${call.arguments}", StackTrace.current);
    setState(() {
      count = call.arguments;
    });
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$count',
          style: const TextStyle(fontSize: 40),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            child: const Icon(Icons.add),
            onPressed: () async {
              ///Flutter 调用 原生 代码
              int? _count = await FlutterMethodChannel.increment(count);
              if(_count != null) {
                setState(() {
                  count = _count;
                });
              }
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            child: const Icon(Icons.remove),
            onPressed: () async {
              ///Flutter 调用 原生 代码
              FlutterMethodChannel.decrement(count);
            },
          ),
        ],
      ),
    );
  }
}
