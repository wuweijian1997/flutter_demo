import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

enum SwipeDirection {
  left,
  right,
}

extension SwipeDirectionExtension on SwipeDirection {
  bool get isLeft => this == SwipeDirection.left;
}

typedef AnimatedCardIndexBuilder = Widget Function({
  int index,
  Widget child,
  SwipeDirection swipeDirection,
  AnimationController animationController,
});

Widget _defaultAnimatedCardIndexBuilder({
  int index,
  Widget child,
  SwipeDirection swipeDirection,
  AnimationController animationController,
}) {
  return _AnimatedCardIndex(
    index: index,
    child: child,
    swipeDirection: swipeDirection,
    animationController: animationController,
  );
}

class CardSwipe extends StatefulWidget {
  ///disable swipe
  final bool disable;

  ///children.isEmpty() display emptyWidget
  final Widget emptyWidget;

  ///swipe duration
  final Duration swipeDuration;

  ///sliding ratio > minSlidingRatio ? animateTo(1) : animateTo(0)
  final double minSlidingRatio;
  final AnimationController animationController;

  final CardSwipeController cardSwipeController;

  final AnimatedCardIndexBuilder animatedCardIndexBuilder;

  CardSwipe({
    key,
    emptyWidget,
    this.disable = false,
    this.animationController,
    this.cardSwipeController,
    this.minSlidingRatio = 0.2,
    this.swipeDuration = const Duration(milliseconds: 150),
    this.animatedCardIndexBuilder = _defaultAnimatedCardIndexBuilder,
  })  : this.emptyWidget = emptyWidget ?? Container(),
        super(key: key);

  @override
  CardSwipeState createState() => CardSwipeState();
}

class CardSwipeState extends State<CardSwipe>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  SwipeDirection _swipeDirection = SwipeDirection.right;
  double _dragStartX;
  CardSwipeController cardSwipeController;

  double get slidingRatio => widget.minSlidingRatio;

  bool get disable => widget.disable;

  Duration get swipeDuration => widget.swipeDuration;

  AnimatedCardIndexBuilder get animatedCardIndexBuilder =>
      widget.animatedCardIndexBuilder;

  @override
  void initState() {
    super.initState();
    this.initController();
  }

  void initController() {
    animationController = widget.animationController ??
        AnimationController.unbounded(vsync: this);
    cardSwipeController =
        widget.cardSwipeController ?? CardSwipeController(list: []);
    cardSwipeController.addListener(() {
      setState(() {});
    });
  }

  List<Widget> get cardList => cardSwipeController?.value ?? [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (cardList == null || cardList.isEmpty) {
      return widget.emptyWidget;
    } else {
      return Stack(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: _buildList(cardList),
      );
    }
  }

  List<Widget> _buildList(cardList) {
    List<Widget> list = [];
    for (int i = cardList.length - 1; i >= 0; i--) {
      Widget item = _buildItem(cardList[i], i);
      if (item != null) {
        list.add(item);
      }
    }
    return list;
  }

  Widget _buildItem(Widget item, int index) {
    assert(animatedCardIndexBuilder != null);
    if (index == 0) {
      item = GestureDetector(
        onHorizontalDragStart: _dragStart,
        onHorizontalDragUpdate: _dragUpdate,
        onHorizontalDragEnd: _dragEnd,
        child: item,
      );
    }
    return animatedCardIndexBuilder.call(
      child: item,
      index: index,
      swipeDirection: _swipeDirection,
      animationController: animationController,
    );
  }

  void _dragStart(DragStartDetails details) {
    _dragStartX = details.localPosition.dx;
  }

  /// Changes the animation to animate to the left or right depending on the
  /// swipe, and sets the AnimationController's value to the swiped amount.
  void _dragUpdate(DragUpdateDetails details) {
    SwipeDirection swipeDirection = (details.localPosition.dx - _dragStartX) < 0
        ? SwipeDirection.left
        : SwipeDirection.right;

    if (swipeDirection != _swipeDirection) {
      _swipeDirection = swipeDirection;
    }

    setState(() {
      //这里的value是移动距离 / 当前widget的宽度的比例
      animationController.value =
          (details.localPosition.dx - _dragStartX).abs() / context.size.width;
    });
  }

  void _dragEnd(DragEndDetails details) {
    _animate(
        nextCard: animationController.value > slidingRatio,
        duration: swipeDuration);
  }

  void _animate({bool nextCard = true, Duration duration}) {
    SwipeDirection swipeDirection = _swipeDirection;
    if (nextCard && !disable) {
      animationController
          .animateTo(1, duration: duration, curve: Curves.linear)
          .then((_) {
        onSwiped(swipeDirection);
      });
    } else {
      animationController.animateTo(
        0,
        duration: duration,
        curve: Curves.linear,
      );
    }
  }

  void onSwiped(SwipeDirection swipeDirection) {
    animationController.value = 0;
    cardSwipeController.removeFirst(swipeDirection);
  }

  void handleSwipedEvent({
    SwipeDirection swipeDirection,
    Duration duration = const Duration(milliseconds: 250),
  }) {
    if (_swipeDirection != swipeDirection) {
      setState(() {
        _swipeDirection = swipeDirection;
      });
    }
    _animate(duration: duration);
  }
}

class _AnimatedCardIndex extends StatefulWidget {
  final int index;
  final SwipeDirection swipeDirection;
  final Widget child;
  final AnimationController animationController;

  _AnimatedCardIndex({
    Key key,
    this.index,
    this.child,
    this.swipeDirection,
    this.animationController,
  }) : super(key: key);

  @override
  _AnimatedCardIndexState createState() => _AnimatedCardIndexState();
}

class _AnimatedCardIndexState extends State<_AnimatedCardIndex> {
  Animation<Offset> _animationOffset;
  Animation<double> _animationAngle;
  Animation<double> _animationScale;

  int get index => widget.index;

  Widget get child => widget.child;

  SwipeDirection get swipeDirection => widget.swipeDirection;

  AnimationController get animationController => widget.animationController;

  //第二张卡片缩放
  ///below cord scale;
  static const double belowCardScale = 0.85;

  //卡片滑动旋转角度, 1 = 360度
  ///card swipe angle; 1 = 360°, 0.5 = 180°
  static const double cardAngle = -0.03;

  @override
  void initState() {
    super.initState();
    //卡片缩放
    _animationScale = animationController.drive(Tween<double>(
      begin: belowCardScale,
      end: 1,
    ));
    updateAnimation(swipeDirection);
  }

  @override
  void didUpdateWidget(_AnimatedCardIndex oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.swipeDirection != swipeDirection) {
      updateAnimation(swipeDirection);
    }
  }

  void updateAnimation(SwipeDirection swipeDirection) {
    _animationOffset = animationController.drive(Tween<Offset>(
      begin: Offset.zero,
      end: Offset(getIsLeftValue(isLeft: swipeDirection.isLeft, value: -1), 0),
    ));
    //卡片旋转角度
    _animationAngle = animationController.drive(Tween<double>(
      begin: 0,
      end: getIsLeftValue(isLeft: swipeDirection.isLeft, value: cardAngle),
    ));
  }

  double getIsLeftValue({bool isLeft, double value}) {
    return isLeft ? value : -value;
  }

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return SlideTransition(
        position: _animationOffset,
        child: RotationTransition(
          turns: _animationAngle,
          alignment: Alignment.center,
          child: child,
        ),
      );
    } else if (index == 1) {
      return ScaleTransition(
        scale: _animationScale,
        child: child,
      );
    } else {
      return SizedBox();
    }
  }
}

class CardSwipeController extends ValueNotifier<List<Widget>> {
  CardSwipeController({List<Widget> list = const []}) : super(list);
  List<RemoveCard> removeList = [];

  addAll({List<Widget> addList}) {
    setState(() {
      value.addAll(addList);
    });
  }

  removeFirst(SwipeDirection swipeDirection) {
    setState(() {
      Widget removeCard = value.removeAt(0);
      removeList.add(RemoveCard(
        swipeDirection: swipeDirection,
        child: removeCard,
      ));
    });
  }

  bool rollbackBySwipeDirection({
    SwipeDirection swipeDirection = SwipeDirection.left,
  }) {
    RemoveCard removeCard = removeList.lastWhere(
        (RemoveCard removeCard) => removeCard.swipeDirection == swipeDirection);
    if (removeCard == null) return false;
    setState(() {
      value.insert(0, removeCard.child);
    });
    removeList.remove(removeCard);
    return true;
  }

  rollback({int count = 1}) {
    int length = removeList.length;
    int startIndex = (length - count).clamp(0, length);
    List<RemoveCard> list = removeList.sublist(startIndex, length);
    List<Widget> widgetList = list.map((e) => e.child).toList();
    setState(() {
      value.insertAll(0, widgetList);
      removeList.removeRange(startIndex, length);
    });
  }

  cleanCache() {
    removeList.clear();
  }

  setState(VoidCallback callback) {
    callback?.call();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    removeList = null;
  }
}

class RemoveCard {
  final SwipeDirection swipeDirection;
  final Widget child;

  RemoveCard({this.swipeDirection, this.child});
}
