import 'dart:math';

import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class ValueNotifierPage extends StatefulWidget {
  static const String rName = 'ValueNotifier';
  @override
  _ValueNotifierPageState createState() => _ValueNotifierPageState();
}

class _ValueNotifierPageState extends State<ValueNotifierPage> {
  CountController controller;

  @override
  void initState() {
    super.initState();
    controller= CountController(value: 0, valueChanged: (value) {
      LogUtil.info(value.toString(), StackTrace.current);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Count(
        controller: controller,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.add(Random().nextInt(10));
        },
      ),
    );
  }
}

class CountController extends ValueNotifier<int> {
  CountController({value = 0, this.valueChanged}) : super(value);
  ValueChanged<int> valueChanged;

  void add(int addValue) {
    value += addValue;
  }

  @override
  set value(int newValue) {
    super.value = newValue;
    valueChanged?.call(value);
  }
}

class _Count extends StatefulWidget {
  final CountController controller;

  _Count({this.controller});

  @override
  __CountState createState() => __CountState();
}

class __CountState extends State<_Count> {
  CountController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? CountController(value: 0);
    controller.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment.center,
    child: Text('${controller.value}'),);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
