import 'package:demo/const/index.dart';
import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class BubbleModel {
  ///圆心位置
  Offset offset;
  ///颜色
  Color color;
  ///半径
  double radius;
  ///移动偏移量
  Offset moveOffset;
  ///加速度
  Offset accelerate;

  ///画布宽高
  double _width;
  double _height;

  BubbleModel({@required width, @required height}) {
    this._width = width;
    this._height = height;
    init();
  }

  init() {
    color = Colors.white.withOpacity(Utils.randomDoubleValue(Const.BUBBLE_MIN_OPACITY, Const.BUBBLE_MAX_OPACITY));
    offset = Offset(Utils.randomDoubleValue(0, _width),
        offset != null ? Utils.randomDoubleValue(_height + 60, _height + 60) : Utils.randomDoubleValue(_height / 2, _height / 2 * 3));
    moveOffset = Offset(Utils.randomMoveX(Utils.randomDoubleValue(Const.BUBBLE_MIN_MOVE_X, Const.BUBBLE_MAX_MOVE_X)),
        Utils.randomDoubleValue(Const.BUBBLE_MIN_MOVE_Y, Const.BUBBLE_MAX_MOVE_Y));
    radius = Utils.randomDoubleValue(Const.BUBBLE_MIN_RADIUS, Const.BUBBLE_MAX_RADIUS);
    accelerate = Offset(0, Utils.randomDoubleValue(Const.BUBBLE_MIN_ACCELERATE, Const.BUBBLE_MAX_ACCELERATE));
  }

  @override
  String toString() {
    return 'BallModel{offset: $offset, color: $color, radius: $radius, moveOffset: $moveOffset, accelerate: $accelerate}';
  }

  @override
  bool operator ==(other) {
    return other.offset == offset &&
        other.color == color &&
        other.radius == radius &&
        other.moveOffset == moveOffset &&
        other.accelerate == accelerate;
  }

  @override
  int get hashCode => super.hashCode;
}
