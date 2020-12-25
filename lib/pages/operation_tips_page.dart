import 'dart:ui';

import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class OperationTipsPage extends StatefulWidget {
  static const String rName = 'OperationTips';

  @override
  _OperationTipsPageState createState() => _OperationTipsPageState();
}

class _OperationTipsPageState extends State<OperationTipsPage>
    with SingleTickerProviderStateMixin {
  OperationTipsController controller;

  @override
  void initState() {
    super.initState();
    controller = OperationTipsController(vsync: this, delegate: DefaultTipsBubbleDelegate(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Hello world",
        style: TextStyle(color: Colors.white),
      ),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment(-0.5, 0),
        child: OperationTips(
          // operationTipsController: controller,
          direction: TipsDirection.horizontal,
          tipsBubble: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Hello world",
              style: TextStyle(color: Colors.white),
            ),
          ),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.open();
        },
      ),
    );
  }
}
