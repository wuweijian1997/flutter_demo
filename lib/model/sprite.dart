import 'package:flutter/material.dart';

/// 雪碧图类
class Sprite {
  /// 雪碧图中图形区域
  Rect position;

  /// 移动偏移
  Offset offset;

  ///透明度
  int alpha;

  /// 旋转角度
  double rotation;

  Sprite({
    required this.position,
    required this.offset,
    required this.alpha,
    required this.rotation,
  });
}
