// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

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
  double _dragStartX;
  bool _isSwipingLeft = false;
  final double _cardAngle = 0.03;
  final double _secondCardScale = 0.85;

  List<String> fileNames;

  void _resetCards() {
    fileNames = [
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

    //卡片缩放
    _animationScale = _controller.drive(Tween<double>(
      begin: _secondCardScale,
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
      //这里的value是移动距离 / 卡片的宽度
      _controller.value =
          (details.localPosition.dx - _dragStartX).abs() / context.size.width;
    });
  }

  void _dragEnd(DragEndDetails details) {
    var velocity =
    (details.velocity.pixelsPerSecond.dx / context.size.width).abs();
    _animate(velocity: velocity);
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

  void _animate({double velocity}) {
    if (_controller.value > 0.2) {
      _controller
          .animateTo(1,
          duration: Duration(milliseconds: 150), curve: Curves.linear)
          .then((_) {
        onSwiped();
      });
    } else {
      _controller.animateTo(0,
          duration: Duration(milliseconds: 150), curve: Curves.linear);
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
      fileNames.removeAt(0);
    });
  }

  void handleSwipedEvent(bool _isLeft) {
    setState(() {
      _updateAnimation(_isLeft);
    });
    _controller
        .animateTo(1,
        duration: Duration(milliseconds: 250),
        curve: Curves.linear)
        .then((_) {
      onSwiped();
    });
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
                overflow: Overflow.clip,
                children: _buildList(),
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
    for (var i = fileNames.length - 1; i >= 0; i--) {
      list.add(_buildItem(fileNames[i], i));
    }
    return list;
  }

  Widget _buildItem(String name, int index) {
    Widget item = Card(name);
    if (index == 0) {
      item = RotationTransition(
        turns: _animationAngle,
        child: SlideTransition(
          position: _animation,
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
