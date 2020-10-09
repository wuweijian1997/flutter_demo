// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


const double _kDefaultIndicatorRadius = 10.0;

class CustomLoading extends StatefulWidget {
  const CustomLoading({
    Key key,
    this.animating = true,
    this.radius = _kDefaultIndicatorRadius,
    this.color = const Color(0xFF3C3C44),
    this.pointerRadius = 1
  }) : super(key: key);

  /// Whether the activity indicator is running its animation.
  ///
  /// Defaults to true.
  final bool animating;

  final Color color;

  /// Radius of the spinner widget.
  ///
  /// Defaults to 10px. Must be positive and cannot be null.
  final double radius;

  ///
  final double pointerRadius;

  @override
  _CustomLoadingState createState() => _CustomLoadingState();
}


class _CustomLoadingState extends State<CustomLoading> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Color get color => widget.color;
  double get pointerRadius => widget.pointerRadius;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    if (widget.animating)
      _controller.repeat();
  }

  @override
  void didUpdateWidget(CustomLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating)
        _controller.repeat();
      else
        _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.radius * 2,
      width: widget.radius * 2,
      child: CustomPaint(
        painter: _CustomLoadingPainter(
          position: _controller,
          activeColor: color,
          radius: widget.radius,
          pointerRadius: pointerRadius
        ),
      ),
    );
  }
}

const double _kTwoPI = math.pi * 2.0;
const int _kTickCount = 12;

const List<int> _alphaValues = <int>[147, 131, 114, 97, 81, 64, 47, 47, 47, 47, 47, 47];

class _CustomLoadingPainter extends CustomPainter {
  _CustomLoadingPainter({
    @required this.position,
    @required this.activeColor,
    pointerRadius,
    double radius,
  }) : tickFundamentalRRect = RRect.fromLTRBR(
    -radius,
    radius / _kDefaultIndicatorRadius,
    -radius / 2.0,
    -radius / _kDefaultIndicatorRadius,
    Radius.circular(pointerRadius),
  ),
        super(repaint: position);

  final Animation<double> position;
  final RRect tickFundamentalRRect;
  final Color activeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    canvas.save();
    canvas.translate(size.width / 2.0, size.height / 2.0);

    final int activeTick = (_kTickCount * position.value).floor();

    for (int i = 0; i < _kTickCount; ++ i) {
      final int t = (i + activeTick) % _kTickCount;
      paint.color = activeColor.withAlpha(_alphaValues[t]);
      canvas.drawRRect(tickFundamentalRRect, paint);
      canvas.rotate(-_kTwoPI / _kTickCount);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CustomLoadingPainter oldPainter) {
    return oldPainter.position != position || oldPainter.activeColor != activeColor;
  }
}
