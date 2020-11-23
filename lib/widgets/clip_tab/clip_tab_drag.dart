import 'package:demo/model/index.dart';
import 'package:demo/widgets/clip_tab/clip_tab_controller.dart';
import 'package:flutter/material.dart';

class ClipTabDrag extends StatefulWidget {
  final Widget child;
  final ClipTabController clipTabController;

  ClipTabDrag({
    this.child,
    this.clipTabController,
  });

  @override
  _ClipTabDragState createState() => _ClipTabDragState();
}

class _ClipTabDragState extends State<ClipTabDrag> {
  static const FULL_TRANSITION_PX = 300;

  ///拖动触摸开始的点
  Offset dragStart;

  Widget get child => widget.child;

  ClipTabController get clipTabController => widget.clipTabController;

  ///开始横向拖动
  onStart(DragStartDetails details) {
    dragStart = details.globalPosition;
    clipTabController.onSlideUpdate(SlideUpdate(
        slideStatus: SlideStatus.dragStart,
        dragStart: dragStart,));
  }

  ///横向拖动中 ing
  onUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      ///滑动方向,向左或向右
      SlideDirection slideDirection;
      ///滑动进度.[0, 1]
      double slidePercent = 0.0;
      ///当前触摸的点
      final newPosition = details.globalPosition;

      ///拖动距离,如果大于零是向右拖动,如果小于零是向左拖动
      final dx = newPosition.dx - dragStart.dx;
      slidePercent = (dx / FULL_TRANSITION_PX).abs().clamp(0.0, 1.0).toDouble();
      if (dx > 0) {
        slideDirection = SlideDirection.leftToRight;
      } else if (dx < 0) {
        slideDirection = SlideDirection.rightToLeft;
      } else {
        slideDirection = SlideDirection.none;
        slidePercent = 0;
      }
      clipTabController.onSlideUpdate(SlideUpdate(
          slideStatus: SlideStatus.dragging,
          direction: slideDirection,
          slidePercent: slidePercent));
    }
  }

  ///横向拖动结束
  onEnd(DragEndDetails details) {
    clipTabController.onSlideUpdate(SlideUpdate(
        slideStatus: SlideStatus.doneDrag,
        direction: SlideDirection.none,
        slidePercent: 0.0));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onStart,
      onHorizontalDragUpdate: onUpdate,
      onHorizontalDragEnd: onEnd,
      child: child,
    );
  }
}
