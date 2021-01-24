
import 'package:demo/effect/index.dart';
import 'package:flutter/material.dart';

class CircularClipRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final Curve curve;
  final Curve reverseCurve;
  final Offset offset;

  CircularClipRoute({
    @required this.builder,
    this.offset = Offset.zero,
    this.transitionDuration = const Duration(milliseconds: 1000),
    this.reverseTransitionDuration = const Duration(milliseconds: 1000),
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
  Duration reverseTransitionDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,
      Widget child) {
    return _CircularClipTransitions(animation: animation, child: child, offset: offset,);
  }

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: curve,
      reverseCurve: reverseCurve,
    );
  }
}

class _CircularClipTransitions extends AnimatedWidget {
  final Widget child;
  final Offset offset;

  const _CircularClipTransitions({
    Key key,
    animation, this.child, this.offset}) :super(key: key, listenable: animation);

  Animation get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CircularClipper(percentage: animation.value, offset: offset),
      child: child,
    );
  }
}

