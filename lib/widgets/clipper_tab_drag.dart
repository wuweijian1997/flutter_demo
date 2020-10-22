import 'dart:async';

import 'package:demo/model/index.dart';
import 'package:flutter/material.dart';

class ClipperTabDrag extends StatefulWidget {
  final bool canDragRight;
  final bool canDragLeft;
  final StreamController<SlideUpdate> slideUpdateStream;

  ClipperTabDrag({this.canDragRight, this.canDragLeft, this.slideUpdateStream});

  @override
  _ClipperTabDragState createState() => _ClipperTabDragState();
}

class _ClipperTabDragState extends State<ClipperTabDrag> {
  static const FULL_TRANSITION_PX = 300;

  ///拖动触摸开始的点
  Offset dragStart;

  ///滑动方向,向左或向右
  SlideDirection slideDirection;

  ///滑动进度.[0, 1]
  double slidePercent = 0.0;

  bool get canDragRight => widget.canDragRight;

  bool get canDragLeft => widget.canDragLeft;

  StreamController<SlideUpdate> get slideUpdateStream =>
      widget.slideUpdateStream;

  ///开始横向拖动
  onStart(DragStartDetails details) {
    dragStart = details.globalPosition;
    slideUpdateStream.add(SlideUpdate(
        updateType: UpdateType.dragStart,
        direction: slideDirection,
        dragStart: dragStart,
        slidePercent: slidePercent));
  }

  ///横向拖动中 ing
  onUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      ///当前触摸的点
      final newPosition = details.globalPosition;

      ///拖动距离,如果大于零是向左拖动,如果小于零是向右拖动
      final dx = dragStart.dx - newPosition.dx;
      slidePercent = (dx / FULL_TRANSITION_PX).abs().clamp(0.0, 1.0).toDouble();
      if (dx > 0 && canDragLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0 && canDragRight) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
        slidePercent = 0;
      }
      slideUpdateStream.add(SlideUpdate(
          updateType: UpdateType.dragging,
          direction: slideDirection,
          slidePercent: slidePercent));
    }
  }

  ///横向拖动结束
  onEnd(DragEndDetails details) {
    slideUpdateStream.add(SlideUpdate(
        updateType: UpdateType.doneDrag,
        direction: SlideDirection.none,
        slidePercent: 0.0));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onStart,
      onHorizontalDragUpdate: onUpdate,
      onHorizontalDragEnd: onEnd,
    );
  }
}