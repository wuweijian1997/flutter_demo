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
  _ListController _listController;

  @override
  void initState() {
    super.initState();
    controller= CountController(value: 0, valueChanged: (value) {
      Log.info(value.toString(), StackTrace.current);
    });
    _listController = _ListController(list: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _Count(
            controller: controller,
          ),
          _ListValue(
            controller: _listController,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.add(Random().nextInt(10));
          _listController.addAll([1,2,3]);
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

class _ListController extends ValueNotifier<List<int>> {

  _ListController({List<int> list}): super(list);

  addAll(List<int> list) {
    value.addAll(list);
    notifyListeners();
  }

  add(int item) {
    value.add(item);
    notifyListeners();
  }


}

class _ListValue extends StatefulWidget {
  final _ListController controller;

  _ListValue({this.controller});

  @override
  __ListValueState createState() => __ListValueState();
}

class __ListValueState extends State<_ListValue> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('_ListValue: ${widget.controller.value}'),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      Log.info('${widget.controller.value}', StackTrace.current);
      setState(() {
      });
    });
  }
}
