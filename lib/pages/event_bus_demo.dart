import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

//1.创建全局的EventBus
final eventBus = EventBus();

class EventBusDemoPage extends StatefulWidget {
  static String rName = 'EventBus';

  @override
  _EventBusDemoPageState createState() => _EventBusDemoPageState();
}

class _EventBusDemoPageState extends State<EventBusDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _ButtonDemo(),
            _TextDemo(),
          ],
        ),
      ),
    );
  }
}

class _ButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('按钮'),
      onPressed: () {
        ///2: 发出事件
        eventBus.fire("你好啊,李银河");
      },
    );
  }
}

class _TextDemo extends StatefulWidget {
  @override
  _TextDemoState createState() => _TextDemoState();
}

class _TextDemoState extends State<_TextDemo> {
  String message = 'helloWorld';


  @override
  void initState() {
    super.initState();
    ///3: 监听事件的类型
    eventBus.on<String>().listen((event) {
      print(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
