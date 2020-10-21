import 'dart:async';

import 'package:demo/clipper/index.dart';
import 'package:demo/model/index.dart';
import 'package:demo/util/assets_util.dart';
import 'package:flutter/material.dart';

final pages = [
  ClipTabModel(
    color: Color(0xFFcd344f),
    image: Assets.rem,
    title: 'This is red page!'
  ),
  ClipTabModel(
      color: Color(0xFF638de3),
      image: Assets.rem02,
      title: 'This is blue page!'
  ),
  ClipTabModel(
      color: Color(0xFFFF682D),
      image: Assets.rem,
      title: 'This is orange page!'
  ),
];

class CircularClipperTabPage extends StatefulWidget {
  static const String rName = 'CircularClipperTab';

  @override
  _CircularClipperTabPageState createState() => _CircularClipperTabPageState();
}

class _CircularClipperTabPageState extends State<CircularClipperTabPage>
    with TickerProviderStateMixin {
  int activeIndex = 0;
  int nextPageIndex = 0;
  int waitingNextPageIndex = -1;
  double slidePercent = 0.0;
  Offset dragStart = Offset.zero;
  SlideDirection slideDirection = SlideDirection.none;
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDrag animatedPageDrag;

  @override
  void initState() {
    super.initState();
    slideUpdateStream = StreamController<SlideUpdate>();
    slideUpdateStream.stream.listen((SlideUpdate event) {
      if (mounted) {
        setState(() {
          if (event.updateType == UpdateType.dragStart) {
            dragStart = event.dragStart;
          }

          ///正在拖动
          if (event.updateType == UpdateType.dragging) {
            slideDirection = event.direction;
            slidePercent = event.slidePercent;

            if (slideDirection == SlideDirection.leftToRight) {
              nextPageIndex = activeIndex - 1;
            } else if (slideDirection == SlideDirection.rightToLeft) {
              nextPageIndex = activeIndex + 1;
            } else {
              nextPageIndex = activeIndex;
            }
          } else if (event.updateType == UpdateType.doneDrag) {
            ///拖动结束
            bool isCompleted = true;
            if (slidePercent < 0.5) {
              isCompleted = false;
              waitingNextPageIndex = activeIndex;
            }
            animatedPageDrag = AnimatedPageDrag(
              slidePercent: slidePercent,
              slideDirection: slideDirection,
              isCompleted: isCompleted,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
            animatedPageDrag.run();
          } else if (event.updateType == UpdateType.animating) {
            ///动画运行中
            slideDirection = event.direction;
            slidePercent = event.slidePercent;
          } else if (event.updateType == UpdateType.doneAnimated) {
            ///动画结束
            if (waitingNextPageIndex != -1) {
              nextPageIndex = waitingNextPageIndex;
              waitingNextPageIndex = -1;
            } else {
              activeIndex = nextPageIndex;
            }
            slideDirection = SlideDirection.none;
            slidePercent = 0.0;
            animatedPageDrag.dispose();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _Body(model: pages[activeIndex],),
          ClipOval(
            clipper:
                CircularClipper(percentage: slidePercent, offset: dragStart),
            child: _Body(model: pages[nextPageIndex], percentage: slidePercent,),
          ),
          _PageDrag(
            canDragRight: activeIndex > 0,
            canDragLeft: activeIndex < pages.length - 1,
            slideUpdateStream: slideUpdateStream,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    slideUpdateStream.close();
    animatedPageDrag?.dispose();
    super.dispose();
  }
}

class _Body extends StatelessWidget {
  final ClipTabModel model;
  final double percentage;

  _Body({this.model, this.percentage = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: model.color,
      height: double.infinity,
      child: Opacity(
        opacity: percentage,
        child: Transform.translate(
          offset: Offset(0, 20 * (1 - percentage)),
          child: Image.asset(model.image, fit: BoxFit.fitWidth,),
        ),
      ),
    );
  }
}

class _PageDrag extends StatefulWidget {
  final bool canDragRight;
  final bool canDragLeft;
  final StreamController<SlideUpdate> slideUpdateStream;

  _PageDrag({this.canDragRight, this.canDragLeft, this.slideUpdateStream});

  @override
  _PageDragState createState() => _PageDragState();
}

class _PageDragState extends State<_PageDrag> {
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

class AnimatedPageDrag {
  static const double PERCENT_PER_MILLISECOND = 0.005;

  ///拖动方向
  final SlideDirection slideDirection;

  ///true: 动画完成, false,动画回弹
  final bool isCompleted;
  AnimationController controller;

  AnimatedPageDrag({
    this.slideDirection,
    this.isCompleted,
    double slidePercent,
    StreamController<SlideUpdate> slideUpdateStream,
    TickerProvider vsync,
  }) {
    double startSlidePercent = slidePercent;
    double endSlidePercent;
    Duration duration;
    if (isCompleted) {
      endSlidePercent = 1.0;
      final slideRemaining = 1.0 - slidePercent;
      duration = Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round());
    } else {
      endSlidePercent = 0.0;
      duration = Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round());
    }
    controller = AnimationController(duration: duration, vsync: vsync)
      ..addListener(() {
        slidePercent =
            lerpDouble(startSlidePercent, endSlidePercent, controller.value);
        slideUpdateStream.add(SlideUpdate(
            updateType: UpdateType.animating,
            direction: slideDirection,
            slidePercent: slidePercent));
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          slideUpdateStream.add(SlideUpdate(
              updateType: UpdateType.doneAnimated,
              direction: slideDirection,
              slidePercent: endSlidePercent));
        }
      });
  }

  run() {
    controller.forward(from: 0);
  }

  dispose() {
    controller.dispose();
  }
}

double lerpDouble(num a, num b, double t) {
  if (a == b || (a?.isNaN == true) && (b?.isNaN == true)) return a?.toDouble();
  a ??= 0.0;
  b ??= 0.0;
  return a + (b - a) * t;
}
