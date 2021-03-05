import 'dart:ui';

import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class OperationTipsPage extends StatefulWidget {
  static const String rName = 'OperationTips';

  @override
  _OperationTipsPageState createState() => _OperationTipsPageState();
}

class _OperationTipsPageState extends State<OperationTipsPage>
    with TickerProviderStateMixin {
  late OperationTipsController topController;
  late OperationTipsController bottomController;
  late OperationTipsController leftController;
  late OperationTipsController rightController;

  @override
  void initState() {
    super.initState();
    topController = OperationTipsController(
      vsync: this,
      direction: TipsDirection.vertical,
      delegate: DefaultTipsBubbleDelegate(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hello world",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
    bottomController = OperationTipsController(
      vsync: this,
      direction: TipsDirection.vertical,
      delegate: DefaultTipsBubbleDelegate(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hello world",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
    leftController = OperationTipsController(
      vsync: this,
      direction: TipsDirection.horizontal,
      delegate: DefaultTipsBubbleDelegate(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hello world",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
    rightController = OperationTipsController(
      vsync: this,
      direction: TipsDirection.horizontal,
      delegate: DefaultTipsBubbleDelegate(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hello world",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  buildOperationTips(OperationTipsController? controller, String text) {
    return OperationTips(
      operationTipsController: controller,
      tipsBubble: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Hello world",
          style: TextStyle(color: Colors.white),
        ),
      ),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(
              child: buildOperationTips(null, 'Test'),
            ),
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   child: Center(
            //     child: Tooltip(
            //       preferBelow: true,
            //       padding: EdgeInsets.all(5),
            //       margin: EdgeInsets.all(5),
            //       message: "HelloWorld",
            //       showDuration: Duration(seconds: 3),
            //       waitDuration: Duration(seconds: 1),
            //       child: Container(width: 50, height: 50, color: Colors.blue,),
            //     ),
            //   ),
            // ),
            Positioned(
              top: 50,
              left: 50,
              child: buildOperationTips(bottomController, 'Bottom'),
            ),
            Positioned(
              top: 50,
              right: 50,
              child: buildOperationTips(leftController, 'Left'),
            ),
            Positioned(
              bottom: 50,
              left: 50,
              child: buildOperationTips(rightController, 'Right'),
            ),
            Positioned(
              bottom: 50,
              right: 50,
              child: buildOperationTips(topController, 'Top'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          topController.open();
          bottomController.open();
          leftController.open();
          rightController.open();
        },
      ),
    );
  }
}
