import 'package:demo/model/index.dart';
import 'package:demo/widgets/clip_tab/index.dart';
import 'package:flutter/material.dart';

class ClippingTabController extends ValueNotifier<double> with ClippingSlideStatusListenerMixin {
  static const double PERCENT_PER_MILLISECOND = 0.001;

  ClippingTabController({
    @required TickerProvider vsync,
    length,
    int initialIndex = 0,
    this.slideSuccessProportion = .5,
  })  : _index = initialIndex,
        _nextPageIndex = initialIndex,
        _length = length,
        _animationController = AnimationController(vsync: vsync),
        super(0);

  ///判定拖动成功的比例
  final double slideSuccessProportion;
  AnimationController _animationController;
  int _length;
  int _index;
  int _nextPageIndex;
  SlideDirection _slideDirection = SlideDirection.none;

  ///拖动开始的坐标
  Offset dragStartOffset = Offset.zero;

  ///拖动是否判定成功,如果拖动比例大于slideSuccessProportion为true,否则为false
  bool _isSlideSuccess = false;

  AnimationController get animationController => _animationController;

  int get index => _index;

  int get nextPageIndex => _nextPageIndex;

  int get length => _length;

  set index(int newIndex) {
    _index = newIndex;
    _nextPageIndex = index;
    syncValue = 0;
  }

  int get nextPage => index + 1 >= length ? 0 : index + 1;

  int get previousPage => index - 1 < 0 ? length - 1 : index - 1;

  set syncValue(double newValue) {
    _animationController.value = newValue;
    value = newValue;
  }

  void init() {
    _animationController
      ..addListener(() {
        onSlideUpdate(SlideUpdate(
            slideStatus: SlideStatus.animating,
            slidePercent: _animationController.value));
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          onSlideUpdate(SlideUpdate(slideStatus: SlideStatus.doneAnimated));
        }
      });
  }

  void animateTo(int nextPage,
      {Curve curve = Curves.ease, Duration duration = kTabScrollDuration}) {
    assert(nextPage != null);
    assert(nextPage >= 0 && (nextPage < length || length == 0));
    assert(duration != null || curve == null);
    if (nextPage == _index || length < 2) return;
    _nextPageIndex = nextPage;
    _animationController.duration = duration;
    _animationController.forward(from: value);
  }

  toPreviousPage() {
    _isSlideSuccess = true;
    animateTo(previousPage);
  }

  toNextPage() {
    _isSlideSuccess = true;
    animateTo(nextPage);
  }

  onSlideUpdate(SlideUpdate slideUpdate) {
    notifyStatusListeners(slideUpdate.slideStatus);
    switch (slideUpdate.slideStatus) {
      case SlideStatus.dragStart:
        onDragStart(slideUpdate);
        break;
      case SlideStatus.dragging:
        onDragging(slideUpdate);
        break;
      case SlideStatus.doneDrag:
        onDragDone(slideUpdate);
        break;
      case SlideStatus.animating:
        onAnimating(slideUpdate);
        break;
      case SlideStatus.doneAnimated:
        onAnimatedDone();
        break;
    }
  }

  ///开始拖动
  onDragStart(SlideUpdate slideUpdate) {
    dragStartOffset = slideUpdate.dragStart;
  }

  ///拖动中
  onDragging(SlideUpdate slideUpdate) {
    _slideDirection = slideUpdate.direction;
    if (_slideDirection == SlideDirection.leftToRight) {
      _nextPageIndex = previousPage;
    } else if (_slideDirection == SlideDirection.rightToLeft) {
      _nextPageIndex = nextPage;
    } else {
      _nextPageIndex = index;
    }
    syncValue = slideUpdate.slidePercent;
  }

  ///拖动结束,开始动画.两种情况,根据滑动比例判断 < 0.5 -切换到下一页, >=0.5-回退到当前页.
  onDragDone(SlideUpdate slideUpdate) {
    onAnimatedStart(slideUpdate: slideUpdate);
  }

  ///动画开始
  onAnimatedStart({SlideUpdate slideUpdate}) {
    Duration duration;
    _isSlideSuccess = value >= slideSuccessProportion;
    if (_isSlideSuccess) {
      final slideRemaining = 1.0 - value;
      duration = Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round());
      _animationController.duration = duration;
      _animationController.forward(from: value);
    } else {
      duration =
          Duration(milliseconds: (value / PERCENT_PER_MILLISECOND).round());
      _animationController.duration = duration;
      _animationController.reverse(from: value);
    }
  }

  ///动画运行中
  onAnimating(SlideUpdate slideUpdate) {
    value = slideUpdate.slidePercent;
  }

  ///动画结束
  onAnimatedDone() {
    if (_isSlideSuccess) {
      index = nextPageIndex;
    }
    _slideDirection = SlideDirection.none;
    syncValue = 0.0;
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

}
