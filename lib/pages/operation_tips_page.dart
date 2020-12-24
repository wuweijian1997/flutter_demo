import 'dart:ui';

import 'package:demo/util/index.dart';
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
    controller = OperationTipsController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.centerLeft,
        child: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                RenderBox renderBox = context.findRenderObject();
                Size size = renderBox.size;
                Offset offset = renderBox.localToGlobal(Offset.zero);
                ToastUtil.showTips(
                  child: TipsBubble(
                    child: GestureDetector(
                      // onTap: ToastUtil.hidden,
                      onTap: () => {},
                      child: Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        child: Text('Hello World'),
                      ),
                    ),
                    color: Colors.blue,
                  ),
                  offset: offset,
                  size: size,
                  tipsSize: Size(100, 110),
                );
              },
              child: Container(
                width: 200,
                height: 200,
                color: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}
