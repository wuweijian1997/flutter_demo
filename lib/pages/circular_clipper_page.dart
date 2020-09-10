import 'dart:math';

import 'package:demo/clipper/index.dart';
import 'package:flutter/material.dart';

class CircularClipperPage extends StatefulWidget {
  static const rName = 'circularClipperPage';

  @override
  _CircularClipperPageState createState() => _CircularClipperPageState();
}

class _CircularClipperPageState extends State<CircularClipperPage> with TickerProviderStateMixin {
  AnimationController animationController;
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 3), vsync: this);
    animationController.forward();

    ///监听动画的改变
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      print(globalKey.currentContext.size);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CircularClipper'),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/rem02.jpg",
            key: globalKey,
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (ctx, child) {
              return ClipOval(
                clipper: CircularClipper(percentage: animationController?.value, offset: const Offset(100.7, 200.7)),
                child: child,
              );
            },
            child: Image.asset(
              "assets/rem.jpg",
            ),
          ),
        ],
      ),
    );
  }
}

