import 'package:flutter/material.dart';

GlobalKey<_CardSwipeState> cardSwipeGlobalKey = GlobalKey<_CardSwipeState>();

class CardSwipe extends StatefulWidget {
  final List<Widget> children;
  final double slidingRatio;
  final bool disable;
  final int swipeEventEndMilliseconds;
  final int swipeEventMilliseconds;
  final Widget emptyWidget;

  //卡片滑动旋转角度, 1 = 360度
  final double cardAngle;

  //第二张卡片缩放
  final double belowCardScale;

  CardSwipe({
    @required this.children,
    this.slidingRatio = 0.2,
    this.disable = false,
    this.swipeEventEndMilliseconds = 150,
    this.swipeEventMilliseconds = 500,
    this.cardAngle = 0.03,
    this.belowCardScale = 0.85,
    emptyWidget,
    key,
  }): this.emptyWidget = emptyWidget ?? Container(), super(key: key);

  @override
  _CardSwipeState createState() => _CardSwipeState();
}

class _CardSwipeState extends State<CardSwipe>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _cardList.isEmpty ? widget.emptyWidget : Stack(
      alignment: Alignment.center,
      overflow: Overflow.clip,
      children: <Widget>[
        ..._buildList(),
      ],
    );
  }

  List<Widget> _buildList() {
    var list = <Widget>[];
    for (var i = _cardList.length - 1; i >= 0; i--) {
      list.add(_buildItem(_cardList[i], i));
    }
    return list;
  }

  Widget _buildItem(Widget item, int index) {
    if (index == 0) {
      item = SlideTransition(
        position: _animation,
        child: RotationTransition(
          turns: _animationAngle,
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
      item = Offstage(
        offstage: true,
        child: item,
      );
//      item = null;
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
      //这里的value是移动距离 / 屏幕的宽度
      _controller.value =
          (details.localPosition.dx - _dragStartX).abs() / context.size.width;
    });
  }

  void _dragEnd(DragEndDetails details) {
    _animate(nextCard: _controller.value > slidingRatio);
  }

  void _updateAnimation(bool _isLeft) {
    _isSwipingLeft = _isLeft;
    _animation = _controller.drive(Tween<Offset>(
      begin: Offset.zero,
      end: _isLeft ? Offset(-1, 0) : Offset(1, 0),
    ));
    _animationAngle = _controller.drive(Tween<double>(
      begin: 0,
      end: _isLeft ? - cardAngle : cardAngle,
    ));
  }

  void _animate({bool nextCard = true, int milliseconds = 150}) {
    if (nextCard && !disable) {
      _controller
          .animateTo(1,
              duration: Duration(milliseconds: milliseconds),
              curve: Curves.linear)
          .then((_) {
        onSwiped();
      });
    } else {
      _controller.animateTo(0,
          duration: Duration(milliseconds: milliseconds), curve: Curves.linear);
    }
  }

  void onSwiped() {
    setState(() {
      _controller.value = 0;
      _cardList.removeAt(0);
    });
  }

  void handleSwipedEvent(bool _isLeft) {
    setState(() {
      _updateAnimation(_isLeft);
    });
    _animate(milliseconds: 250);
  }
}
