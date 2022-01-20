import 'package:demo/const/index.dart';
import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class BubbleModel {
  ///圆心位置
  Offset? offset;

  ///颜色
  late Color color;

  ///半径
  late double radius;

  ///移动偏移量
  late Offset moveOffset;

  ///加速度
  late Offset accelerate;

  ///画布宽高
  late double _width;
  late double _height;

  BubbleModel({required width, required height}) {
    _width = width;
    _height = height;
    init();
  }

  init() {
    color = Colors.white.withOpacity(Utils.randomDoubleValue(
        Const.bubbleMinOpacity, Const.bubbleMaxOpacity));
    offset = Offset(
        Utils.randomDoubleValue(0, _width),
        offset != null
            ? Utils.randomDoubleValue(_height + 60, _height + 60)
            : Utils.randomDoubleValue(_height / 2, _height / 2 * 3));
    moveOffset = Offset(
        Utils.randomMoveX(Utils.randomDoubleValue(
            Const.bubbleMinMoveX, Const.bubbleMaxMoveX)),
        Utils.randomDoubleValue(
            Const.bubbleMinMoveY, Const.bubbleMaxMoveY));
    radius = Utils.randomDoubleValue(
        Const.bubbleMinRadius, Const.bubbleMaxRadius);
    accelerate = Offset(
        0,
        Utils.randomDoubleValue(
            Const.bubbleMinAccelerate, Const.bubbleMaxAccelerate));
  }

  @override
  String toString() {
    return 'BallModel{offset: $offset, color: $color, radius: $radius, moveOffset: $moveOffset, accelerate: $accelerate}';
  }

  @override
  bool operator ==(other) {
    return other is BubbleModel &&
        other.offset == offset &&
        other.color == color &&
        other.radius == radius &&
        other.moveOffset == moveOffset &&
        other.accelerate == accelerate;
  }

  @override
  int get hashCode => super.hashCode + 1;
}
