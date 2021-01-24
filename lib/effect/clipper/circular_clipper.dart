import 'dart:math';

import 'package:flutter/material.dart';

class CircularClipper extends CustomClipper<Rect> {
  ///百分比, 0-> 1,1 => 全部显示
  final double percentage;
  final Offset offset;

  const CircularClipper({this.percentage = 0, this.offset = Offset.zero});

  @override
  Rect getClip(Size size) {
    double maxValue = maxLength(size, offset) * percentage;
    return Rect.fromLTRB(-maxValue + offset.dx, -maxValue + offset.dy, maxValue + offset.dx, maxValue + offset.dy);
  }

  @override
  bool shouldReclip(CircularClipper oldClipper) {
    return percentage != oldClipper.percentage || offset != oldClipper.offset;
  }

  ///     |
  ///   1 |  2
  /// ---------
  ///   3 |  4
  ///     |
  double maxLength(Size size, Offset offset) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    if (offset.dx < centerX && offset.dy < centerY) {
      ///1
      return getEdge(size.width - offset.dx, size.height - offset.dy);
    } else if (offset.dx > centerX && offset.dy < centerY) {
      ///2
      return getEdge(offset.dx, size.height - offset.dy);
    } else if (offset.dx < centerX && offset.dy > centerY) {
      ///3
      return getEdge(size.width - offset.dx, offset.dy);
    } else {
      ///4
      return getEdge(offset.dx, offset.dy);
    }
  }

  double getEdge(double width, double height) {
    return sqrt(pow(width, 2) + pow(height, 2));
  }
}
