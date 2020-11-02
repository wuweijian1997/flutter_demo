import 'dart:math';

import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeChatDropDown extends SingleChildRenderObjectWidget {
  const WeChatDropDown({
    Key key,
    Widget child,
    this.hasLayoutExtent,
    this.layoutExtent,
  }) : super(key: key, child: child);

  final bool hasLayoutExtent;
  final double layoutExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return WeChatDropDownSliver(
      hasLayoutExtent: hasLayoutExtent,
      refreshLayoutExtent: layoutExtent,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant WeChatDropDownSliver renderObject) {
    renderObject
      ..hasLayoutExtent = hasLayoutExtent
      ..childLayoutExtent = layoutExtent;
  }
}

class WeChatDropDownSliver extends RenderSliverSingleBoxAdapter {
  bool _hasLayoutExtent;
  double _childLayoutExtent;

  WeChatDropDownSliver({bool hasLayoutExtent, double refreshLayoutExtent})
      : _hasLayoutExtent = hasLayoutExtent,
        _childLayoutExtent = refreshLayoutExtent;

  set hasLayoutExtent(bool value) {
    assert(value != null);
    if (value == _hasLayoutExtent) return;
    _hasLayoutExtent = value;
    markNeedsLayout();
  }

  set childLayoutExtent(double value) {
    assert(value != null);
    assert(value > 0);
    _childLayoutExtent = value;
    markNeedsLayout();
  }

  // 获取子组件大小
  double get childSize => child.size.height;

  double layoutExtentOffsetCompensation = 0.0;

  @override
  void performLayout() {
    final SliverConstraints constraints = this.constraints;
    final double layoutExtent = _hasLayoutExtent ? _childLayoutExtent : 0;
    if (layoutExtentOffsetCompensation != layoutExtent) {
      geometry = SliverGeometry(
          scrollOffsetCorrection:
              layoutExtent - layoutExtentOffsetCompensation);
      layoutExtentOffsetCompensation = layoutExtent;
      return;
    }
    final bool active = constraints.overlap < 0.0 || layoutExtent > 0.0;

    /// 头部滑动的距离
    final double overScrolledExtent = min(constraints.overlap, 0.0).abs();
    ///将 SliverConstraints转化为BoxConstraints对child进行layout
    child.layout(
        constraints.asBoxConstraints(
          ///最大范围: 布局的范围 +　滚动的范围
          maxExtent: layoutExtent + overScrolledExtent,
        ),
        parentUsesSize: true);
    if (active) {
      final maxPaintExtent =
          max(max(childSize, layoutExtent) - constraints.scrollOffset, 0.0);
      geometry = SliverGeometry(
        scrollExtent: layoutExtent,
        paintExtent: maxPaintExtent,
        maxPaintExtent: maxPaintExtent,
        paintOrigin: -overScrolledExtent - constraints.scrollOffset,
        layoutExtent: max(layoutExtent - constraints.scrollOffset, 0.0),
      );
    } else {
      /// 如果不想显示可以直接设置为 zero
      geometry = SliverGeometry.zero;
    }
  }
}
