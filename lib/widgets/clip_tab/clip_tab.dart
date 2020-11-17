import 'dart:async';
import 'package:demo/model/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

typedef TabsBuilder = Widget Function(
  BuildContext context,
  int activeIndex,
  int nextPageIndex,
  double progress,
  Offset startingOffset,
);

class ClipTab extends StatefulWidget {
  final int tabs;
  final TabsBuilder tabsBuilder;

  ClipTab({
    Key key,
    @required this.tabs,
    @required this.tabsBuilder,
  }) : super(key: key);

  @override
  _ClipTabState createState() => _ClipTabState();
}

class _ClipTabState extends State<ClipTab> with SingleTickerProviderStateMixin {
  static const double PERCENT_PER_MILLISECOND = 0.005;

  ///判定拖动成功的比例
  double slideSuccessProportion = .5;
  int activeIndex = 0;
  int nextPageIndex = 0;

  double slidePercent = 0.0;

  ///拖动是否判定成功,如果拖动比例大于slideSuccessProportion为true,否则为false
  bool _isSlideSuccess = false;

  ///拖动开始的坐标
  Offset dragStartOffset = Offset.zero;
  SlideDirection slideDirection = SlideDirection.none;
  StreamController<SlideUpdate> slideUpdateStream;
  AnimationController animationController;

  TabsBuilder get tabsBuilder => widget.tabsBuilder;

  int get tabs => widget.tabs;

  @override
  void initState() {
    super.initState();
    slideUpdateStream = StreamController<SlideUpdate>();
    slideUpdateStream.stream.listen(onSlideUpdate);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(() {
        slidePercent = lerpDouble(
            slidePercent, _isSlideSuccess ? 1 : 0, animationController.value);
        slideUpdateStream.add(SlideUpdate(
            updateType: UpdateType.animating,
            direction: slideDirection,
            slidePercent: slidePercent));
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          slideUpdateStream
              .add(SlideUpdate(updateType: UpdateType.doneAnimated));
        }
      });
  }

  double lerpDouble(num a, num b, double t) {
    if (a == b || (a?.isNaN == true) && (b?.isNaN == true))
      return a?.toDouble();
    a ??= 0.0;
    b ??= 0.0;
    return a + (b - a) * t;
  }

  onSlideUpdate(SlideUpdate slideUpdate) {
    if (mounted) {
      setState(() {
        switch (slideUpdate.updateType) {
          case UpdateType.dragStart:
            onDragStart(slideUpdate);
            break;
          case UpdateType.dragging:
            onDragging(slideUpdate);
            break;
          case UpdateType.doneDrag:
            onDragDone(slideUpdate);
            break;
          case UpdateType.animating:
            onAnimating(slideUpdate);
            break;
          case UpdateType.doneAnimated:
            onAnimatedDone();
            break;
          default:
            break;
        }
      });
    }
  }

  ///开始拖动
  onDragStart(SlideUpdate slideUpdate) {
    dragStartOffset = slideUpdate.dragStart;
  }

  ///拖动中
  onDragging(SlideUpdate slideUpdate) {
    slideDirection = slideUpdate.direction;
    slidePercent = slideUpdate.slidePercent;

    if (slideDirection == SlideDirection.leftToRight) {
      nextPageIndex = activeIndex - 1;
    } else if (slideDirection == SlideDirection.rightToLeft) {
      nextPageIndex = activeIndex + 1;
    } else {
      nextPageIndex = activeIndex;
    }
  }

  ///拖动结束,开始动画.两种情况,根据滑动比例判断 < 0.5 -切换到下一页, >=0.5-回退到当前页.
  onDragDone(SlideUpdate slideUpdate) {
    onAnimatedStart(slideUpdate: slideUpdate);
  }

  ///动画开始
  onAnimatedStart({SlideUpdate slideUpdate}) {
    Duration duration;
    _isSlideSuccess = slidePercent >= .5;
    if (_isSlideSuccess) {
      final slideRemaining = 1.0 - slidePercent;
      duration = Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round());
    } else {
      duration = Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round());
    }
    animationController.duration = duration;
    animationController.forward(from: 0);
  }

  ///动画运行中
  onAnimating(SlideUpdate slideUpdate) {
    slideDirection = slideUpdate.direction;
    slidePercent = slideUpdate.slidePercent;
  }

  ///动画结束
  onAnimatedDone() {
    if (_isSlideSuccess) {
      activeIndex = nextPageIndex;
      nextPageIndex = activeIndex;
    }
    slideDirection = SlideDirection.none;
    slidePercent = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return ClipperTabDrag(
      canDragRight: activeIndex > 0,
      canDragLeft: activeIndex < tabs - 1,
      slideUpdateStream: slideUpdateStream,
      child: tabsBuilder.call(
        context,
        activeIndex,
        nextPageIndex,
        slidePercent,
        dragStartOffset,
      ),
    );
  }

  @override
  void dispose() {
    slideUpdateStream.close();
    animationController.dispose();
    super.dispose();
  }
}
