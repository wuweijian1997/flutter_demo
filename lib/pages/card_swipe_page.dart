// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'dart:ui';

import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CardSwipeDemo extends StatefulWidget {
  static String rName = 'card_swipe';

  @override
  _CardSwipeDemoState createState() => _CardSwipeDemoState();
}

class _CardSwipeDemoState extends State<CardSwipeDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  Animation<double> _animationAngle;
  Animation<double> _animationScale;
  Animation<double> _animationIconScale;
  Animation<double> _animationTransformXRight;
  Animation<double> _animationTransformXLeft;
  double _dragStartX;
  bool _isSwipingLeft = false;
  double _slidingRatio = 0.2;
  bool disable = false;
  int swipeEventMilliseconds = 150;

  //卡片滑动旋转角度, 1 = 360度
  final double _cardAngle = 0.03;

  //第二张卡片缩放
  final double _secondCardScale = 0.85;
  final double _cardStatusIconScale = 0.7;

  List<String> cards;

  void _resetCards() {
    cards = [
      'assets/eat_cape_town_sm.jpg',
      'assets/eat_new_orleans_sm.jpg',
      'assets/eat_sydney_sm.jpg',
    ];
  }

  @override
  void initState() {
    super.initState();
    _resetCards();
    _controller = AnimationController.unbounded(vsync: this);
    //卡片左右移动
    _animation = _controller.drive(Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1, 0),
    ));

    //卡片旋转角度
    _animationAngle = _controller.drive(Tween<double>(
      begin: 0,
      end: _cardAngle,
    ));

    _animationTransformXRight = _controller.drive(Tween<double>(
      begin: 260.0,
      end: -150.0,
    ));

    _animationTransformXLeft = _controller.drive(Tween<double>(
      begin: -260.0,
      end: 150.0,
    ));

    //卡片缩放
    _animationScale = _controller.drive(Tween<double>(
      begin: _secondCardScale,
      end: 1,
    ));

    _animationIconScale = _controller.drive(Tween<double>(
      begin: _cardStatusIconScale,
      end: 1,
    ));
  }

  /// Sets the starting position the user dragged from.
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
    _animate(nextCard: _controller.value > _slidingRatio);
  }

  void _updateAnimation(bool _isLeft) {
    _isSwipingLeft = _isLeft;
    _animation = _controller.drive(Tween<Offset>(
      begin: Offset.zero,
      end: _isLeft ? Offset(-1, 0) : Offset(1, 0),
    ));
    _animationAngle = _controller.drive(Tween<double>(
      begin: 0,
      end: _isLeft ? -_cardAngle : _cardAngle,
    ));
  }

  void _animate({bool nextCard = true}) {
    if (nextCard && !disable) {
      _controller
          .animateTo(1,
              duration: Duration(milliseconds: swipeEventMilliseconds),
              curve: Curves.linear)
          .then((_) {
        onSwiped();
      });
    } else {
      _controller.animateTo(0,
          duration: Duration(milliseconds: swipeEventMilliseconds),
          curve: Curves.linear);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSwiped() {
    setState(() {
      _controller.value = 0;
      cards.removeAt(0);
    });
  }

  void handleSwipedEvent(bool _isLeft) {
    setState(() {
      _updateAnimation(_isLeft);
    });
    _animate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Swipe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                overflow: Overflow.clip,
                children: <Widget>[
                  ..._buildList(),
                  ..._buildStatusIcons(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: const Text('左滑'),
                    onPressed: () => handleSwipedEvent(true),
                  ),
                  RaisedButton(
                    child: const Text('重置'),
                    onPressed: () {
                      setState(() {
                        _resetCards();
                      });
                    },
                  ),
                  RaisedButton(
                    child: const Text('右滑'),
                    onPressed: () => handleSwipedEvent(false),
                  ),
                  RaisedButton(
                    child: Text(disable ? '禁用' : '开启'),
                    onPressed: () {
                      setState(() {
                        disable = !disable;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    var list = <Widget>[];
    for (var i = cards.length - 1; i >= 0; i--) {
      list.add(_buildItem(cards[i], i));
    }
    return list;
  }

  List<Widget> _buildStatusIcons() {
//    final size = MediaQuery.of(context).size;
//    print('kafka Size: $size');
    var list = <Widget>[];
    if (_isSwipingLeft) {
      list.add(TransformXTransition(
        turns: _animationTransformXLeft,
        maxValue: 0,
        child: ScaleTransition(
          scale: _animationIconScale,
          child: Icon(
            Icons.sentiment_dissatisfied,
            size: 100,
          ),
        ),
      ));
    } else {
      list.add(TransformXTransition(
        turns: _animationTransformXRight,
        minValue: 0,
        child: ScaleTransition(
          scale: _animationIconScale,
          child: Icon(
            Icons.sentiment_satisfied,
            size: 100,
            color: Colors.red,
          ),
        ),
      ));
    }
    return list;
  }

  Widget _buildItem(String name, int index) {
    Widget item = Card(name);
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
    }
    return item;
  }
}

class Card extends StatelessWidget {
  final String imageAssetName;

  Card(this.imageAssetName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AspectRatio(
        aspectRatio: 3 / 5,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: AssetImage(imageAssetName),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
