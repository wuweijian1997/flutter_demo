import 'package:flutter/material.dart';

enum SlideStatus {
  ///拖动开始
  dragStart,
  ///拖动中
  dragging,
  ///拖动结束
  doneDrag,
  ///动画运行中
  animating,
  ///动画结束
  doneAnimated,
}

enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

class SlideUpdate {
  final SlideStatus slideStatus;
  final SlideDirection direction;
  final double slidePercent;
  final Offset dragStart;

  SlideUpdate({this.slideStatus, this.direction, this.slidePercent, this.dragStart});
}