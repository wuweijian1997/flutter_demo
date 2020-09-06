import 'dart:math';

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

class CircularClipper extends CustomClipper<Rect> {
  ///百分比, 0-> 1,1 => 全部显示
  final double percentage;
  final Offset offset;

  const CircularClipper({this.percentage = 0, this.offset = Offset.zero});

  @override
  Rect getClip(Size size) {
    double maxValue = maxLength(size, offset) * percentage;
    return Rect.fromLTRB(-maxValue + offset.dx, -maxValue + offset.dy, maxValue + offset.dx, maxValue + offset.dy);
  }

  @override
  bool shouldReclip(CircularClipper oldClipper) {
    return percentage != oldClipper.percentage || offset != oldClipper.offset;
  }

  ///     |
  ///   1 |  2
  /// ---------
  ///   3 |  4
  ///     |
  double maxLength(Size size, Offset offset) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    if (offset.dx < centerX && offset.dy < centerY) {
      ///1
      return getEdge(size.width - offset.dx, size.height - offset.dy);
    } else if (offset.dx > centerX && offset.dy < centerY) {
      ///2
      return getEdge(offset.dx, size.height - offset.dy);
    } else if (offset.dx < centerX && offset.dy > centerY) {
      ///3
      return getEdge(size.width - offset.dx, offset.dy);
    } else {
      ///4
      return getEdge(offset.dx, offset.dy);
    }
  }

  double getEdge(double width, double height) {
    return sqrt(pow(width, 2) + pow(height, 2));
  }
}
