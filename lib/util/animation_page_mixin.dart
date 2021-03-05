import 'dart:math';

import 'package:flutter/material.dart';

mixin AnimationPageMixin {

  Duration animationPageDuration = const Duration(milliseconds: 1000);

  List<Widget> initAnimation(List<Widget> widgetList, AnimationController controller) {
    List<Widget> list = [];
    int count = widgetList.length;
    for (int i = 0; i < count; i++) {
      final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      list.add(buildAnimationWidget(animation, controller, widgetList[i]));
    }
    return list;
  }

  buildAnimationWidget(Animation animation, AnimationController controller, Widget child) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: pow(animation.value, 2).toDouble(),
          child: Transform(
            transform: buildTransform(animation),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  buildTransform(Animation animation) {
    return Matrix4.translationValues( 10 * (1.0 - pow(animation.value, 2)), 10 * (1.0 - pow(animation.value, 2)), 0.0);
  }
}