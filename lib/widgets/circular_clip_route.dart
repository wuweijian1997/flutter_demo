import 'package:flutter/material.dart';

class CircularClipRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final Curve curve;
  final Curve reverseCurve;

  CircularClipRoute({
    @required this.builder,
    this.transitionDuration,
    this.curve = Curves.easeInOutCubic,
    this.reverseCurve = Curves.easeInOutCubic});

  ///未显示部分的背景颜色
  @override
  Color get barrierColor => null;

  ///用于可消除障碍的语义标签
  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  bool get maintainState => false;

  @override
  Duration transitionDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,
      Widget child) {

  }

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
        parent: super.createAnimationController(),
        curve: curve,
        reverseCurve: reverseCurve
    );
  }
}

class _CircularClipTransitions extends StatelessWidget {

}