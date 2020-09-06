import 'dart:math';

import 'package:flutter/material.dart';

class CircularClipperPage extends StatefulWidget {
  static const rName = 'imgClipperPage';

  @override
  _CircularClipperPageState createState() => _CircularClipperPageState();
}

class _CircularClipperPageState extends State<CircularClipperPage> with TickerProviderStateMixin{
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 3),vsync: this);
    animationController.forward();
    ///监听动画的改变
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
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
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/rem02.jpg",
                width: 300,
                height: 600,
                fit: BoxFit.cover,
              ),
              AnimatedBuilder(
                animation: animationController,
                builder: (ctx, child) {
                  return ClipOval(
                    clipper: CircularClipper(percentage: animationController?.value, offset: const Offset(150, 300)),
                    child: child,
                  );
                },
                child: Image.asset(
                  "assets/rem.jpg",
                  width: 300,
                  height: 600,
                  fit: BoxFit.cover,

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircularClipper extends CustomClipper<Rect> {
  final double percentage;
  final Offset offset;

  const CircularClipper({this.percentage = 0, this.offset = Offset.zero});

  @override
  Rect getClip(Size size) {
    double maxValue = maxLength(size, offset) * percentage;
    return Rect.fromLTRB(-maxValue + offset.dx, -maxValue + offset.dy,  maxValue+ offset.dx, maxValue+ offset.dy);
  }

  @override
  bool shouldReclip(CircularClipper oldClipper) {
    return percentage != oldClipper.percentage;
  }

  ///     |
  ///   1 |  2
  /// ---------
  ///   3 |  4
  ///     |
  double maxLength(Size size, Offset offset) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    if(offset.dx < centerX && offset.dy < centerY) {
      ///1
      return getEdge(size.width - offset.dx, size.height - offset.dy);
    } else if(offset.dx > centerX && offset.dy < centerY) {
      ///2
      return getEdge(offset.dx, size.height - offset.dy);
    } else if(offset.dx <centerX && offset.dy > centerY) {
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

