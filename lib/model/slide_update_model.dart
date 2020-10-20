import 'package:flutter/material.dart';

enum UpdateType {
  dragStart,
  dragging,
  doneDrag,
  animating,
  doneAnimated,
}

enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

class SlideUpdate {
  final UpdateType updateType;
  final SlideDirection direction;
  final double slidePercent;
  final Offset dragStart;

  SlideUpdate({this.updateType, this.direction, this.slidePercent, this.dragStart});
}