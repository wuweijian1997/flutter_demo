import 'dart:math';

import 'package:flutter/material.dart';

class ConstDemo extends StatefulWidget {
  static String rName = 'ConstDemo';

  @override
  _ConstDemoState createState() => _ConstDemoState();
}

class _ConstDemoState extends State<ConstDemo> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            _Demo("没有const"),
            const _Demo("有const"),
            _StatefulDemo(count: count, key: UniqueKey(),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            count++;
          });
        },
      ),
    );
  }
}

class _Demo extends StatelessWidget {
  final title;

  const _Demo(this.title);

  @override
  Widget build(BuildContext context) {
    print("Demo_Build $title");
    return Container(
      child: Column(
        children: [
          Text(title),
          _Demo2(title)
        ],
      ),
    );
  }
}

class _Demo2 extends StatelessWidget {
  final String title;

  _Demo2(this.title);

  @override
  Widget build(BuildContext context) {
    print("Demo2_Build $title");
    return Text(title);
  }
}

class _StatefulDemo extends StatefulWidget {
  final int count;

  _StatefulDemo({this.count, Key key}) : super(key: key);

  @override
  __StatefulDemoState createState() => __StatefulDemoState();
}

class __StatefulDemoState extends State<_StatefulDemo> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(_StatefulDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}
