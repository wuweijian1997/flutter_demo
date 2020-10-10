import 'package:flutter/material.dart';

GlobalKey<_CardSwipeState> cardSwipeGlobalKey = GlobalKey();

typedef CardSwipeCallback = void Function(List<Widget> cardList);

class CardSwipe extends StatefulWidget {
  ///card list
  final List<Widget> children;
  ///sliding ratio > slidingRatio => animateTo(1); sliding ratio <= slidingRatio => animateTo(0)
  final double slidingRatio;
  ///disable swipe
  final bool disable;
  ///children.isEmpty() display emptyWidget
  final Widget emptyWidget;
  ///swipe duration
  final Duration swipeDuration;
  ///swipe event duration
  final Duration swipeEventDuration;

  //卡片滑动旋转角度, 1 = 360度
  ///card swipe angle; 1 = 360°, 0.5 = 180°
  final double cardAngle;

  //第二张卡片缩放
  ///below cord scale;
  final double belowCardScale;

  /// card swipe callback
  final CardSwipeCallback cardSwipeCallback;

  CardSwipe({
    @required this.children,
    this.slidingRatio = 0.2,
    this.disable = false,
    this.cardAngle = 0.03,
    this.belowCardScale = 0.85,
    this.swipeDuration = const Duration(milliseconds: 150),
    this.swipeEventDuration = const Duration(milliseconds: 250),
    emptyWidget,
    key,
    this.cardSwipeCallback
  })  : this.emptyWidget = emptyWidget ?? Container(),
        super(key: key);

  @override
  _CardSwipeState createState() => _CardSwipeState();
}

class _CardSwipeState extends State<CardSwipe> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  Animation<double> _animationAngle;
  Animation<double> _animationScale;
  List<Widget> _cardList = [];
  bool _isSwipingLeft = false;
  double _dragStartX;

  double get cardAngle => widget.cardAngle;

  double get belowCardScale => widget.belowCardScale;

  double get slidingRatio => widget.slidingRatio;

  List<Widget> get children => widget.children;

  bool get disable => widget.disable;

  Duration get swipeEventDuration => widget.swipeEventDuration;

  Duration get swipeDuration => widget.swipeDuration;

  CardSwipeCallback get cardSwipeCallback => widget.cardSwipeCallback;

  Widget lastSwipeWidget;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this);
    this.initAnimation();
    _cardList = children;
  }

  void initAnimation() {
    //卡片左右移动
    _animation = _controller.drive(Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1, 0),
    ));

    //卡片旋转角度
    _animationAngle = _controller.drive(Tween<double>(
      begin: 0,
      end: cardAngle,
    ));

    //卡片缩放
    _animationScale = _controller.drive(Tween<double>(
      begin: belowCardScale,
      end: 1,
    ));
  }

  add(List<Widget> addList) {
    _cardList.addAll(addList);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _cardList.isEmpty
        ? widget.emptyWidget
        : Stack(
            // clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            overflow: Overflow.visible,
            children: <Widget>[
              ..._buildList(_cardList),
            ],
          );
  }

  List<Widget> _buildList(cardList) {
    var list = <Widget>[];
    for (var i = cardList.length - 1; i >= 0; i--) {
      var item = _buildItem(cardList[i], i);
      if (item != null) {
        list.add(item);
      }
    }
    return list;
  }

  Widget _buildItem(Widget item, int index) {
    if (index == 0) {
      item = SlideTransition(
        position: _animation,
        child: RotationTransition(
          turns: _animationAngle,
          alignment: Alignment.center,
          child: GestureDetector(
            onHorizontalDragStart: _dragStart,
            onHorizontalDragUpdate: _dragUpdate,
            onHorizontalDragEnd: _dragEnd,
            child: item,
          ),
        ),
      );
    } else if (index == 1) {
      item = ScaleTransition(
        scale: _animationScale,
        child: item,
      );
    } else {
      item = null;
    }
    return item;
  }

  void _dragStart(DragStartDetails details) {
    _dragStartX = details.localPosition.dx;
  }

  /// Changes the animation to animate to the left or right depending on the
  /// swipe, and sets the AnimationController's value to the swiped amount.
  void _dragUpdate(DragUpdateDetails details) {
    var isSwipingLeft = (details.localPosition.dx - _dragStartX) < 0;
    if (isSwipingLeft != _isSwipingLeft) {
      _updateAnimation(isSwipingLeft);
    }

    setState(() {
      //这里的value是移动距离 / 当前context的宽度
      _controller.value = (details.localPosition.dx - _dragStartX).abs() / context.size.width;
    });
  }

  void _dragEnd(DragEndDetails details) {
    _animate(nextCard: _controller.value > slidingRatio, duration: swipeDuration);
  }

  void _updateAnimation(bool isLeft) {
    _isSwipingLeft = isLeft;
    _animation = _controller.drive(Tween<Offset>(
      begin: Offset.zero,
      end: isLeft ? Offset(-1, 0) : Offset(1, 0),
    ));
    _animationAngle = _controller.drive(Tween<double>(
      begin: 0,
      end: isLeft ? -cardAngle : cardAngle,
    ));
  }

  void _animate({bool nextCard = true, @required Duration duration}) {
    if (nextCard && !disable) {
      _controller.animateTo(1, duration: duration, curve: Curves.linear).then((_) {
        onSwiped();
      });
    } else {
      _controller.animateTo(0, duration: duration, curve: Curves.linear);
    }
  }

  void onSwiped() {
    setState(() {
      _controller.value = 0;
      lastSwipeWidget = _cardList.removeAt(0);
    });
    cardSwipeCallback?.call(_cardList);
  }

  void handleSwipedEvent({bool isLeft}) {
    setState(() {
      _updateAnimation(isLeft);
    });
    _animate(duration: swipeEventDuration);
  }
}
