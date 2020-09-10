import 'dart:math';

import 'package:demo/clipper/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class AnimationRoutePage extends StatefulWidget {
  static const rName = 'animationRoutePage';

  @override
  _AnimationRoutePageState createState() => _AnimationRoutePageState();
}

class _AnimationRoutePageState extends State<AnimationRoutePage> {
  onAnimationPage(Offset offset) {
    Navigator.of(context).push(PageRouteBuilder(
        barrierLabel: "Hello World",
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder:
            (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                _transitionsBuilder(context, animation, secondaryAnimation, child, offset),
        pageBuilder: (ctx, animation1, animation2) {
          return ConstDemo();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (_, index) => SizedBox(
          height: 10,
        ),
        itemCount: 10,
        itemBuilder: (_, index) {
          Color color = Colors.accents[Random().nextInt(Colors.accents.length)];
          return GestureDetector(
            onTapDown: (detail) {
              onAnimationPage(detail.globalPosition);
            },
            child: Container(
              height: 200,
              color: color,
            ),
          );
        },
      ),
    );
  }

  Widget _transitionsBuilder(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,
      Widget child, Offset offset) {
    return ClipOval(
      clipper: CircularClipper(percentage: animation?.value, offset: offset),
      child: child,
    );
  }
}
