import 'dart:math';

import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomRefreshWidget extends SingleChildRenderObjectWidget {
  const CustomRefreshWidget(
      {Key key, Widget child, this.hasLayoutExtent, this.layoutExtent})
      : super(key: key, child: child);

  final bool hasLayoutExtent;
  final double layoutExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SimpleRefreshSliver(
        hasLayoutExtent: hasLayoutExtent, layoutExtent: layoutExtent);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant SimpleRefreshSliver renderObject) {
    renderObject
      ..hasLayoutExtent = hasLayoutExtent
      ..layoutExtent = layoutExtent;
  }
}

class SimpleRefreshSliver extends RenderSliverSingleBoxAdapter {
  bool _hasLayoutExtent;
  double _layoutExtent;

  SimpleRefreshSliver({bool hasLayoutExtent, double layoutExtent})
      : _hasLayoutExtent = hasLayoutExtent,
        _layoutExtent = layoutExtent;

  set hasLayoutExtent(bool value) {
    assert(value != null);
    if (value == _hasLayoutExtent) return;
    _hasLayoutExtent = value;
    markNeedsLayout();
  }

  get hasLayoutExtent => _hasLayoutExtent;

  double get layoutExtent => _layoutExtent;

  set layoutExtent(double value) {
    assert(value != null);
    assert(value > 0);
    _layoutExtent = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final SliverConstraints constraints = this.constraints;
    final bool active = constraints.overlap < 0.0;

    /// 头部滑动的距离
    final double overScrolledExtent =
        constraints.overlap < 0.0 ? constraints.overlap.abs() : 0.0;
    double layoutExtentSize = max(overScrolledExtent, layoutExtent);

    ///将 SliverConstraints转化为BoxConstraints对child进行layout
    child.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    if (active || hasLayoutExtent) {
      geometry = SliverGeometry(
        scrollExtent: layoutExtentSize,
        maxPaintExtent: layoutExtentSize,

        /// RefreshWidget 的绘制起始位置
        paintOrigin: 0,
        paintExtent: max(
          max(child.size.height, layoutExtentSize),
          0.0,
        ),

        /// 布局占位
        layoutExtent: hasLayoutExtent
            ? layoutExtentSize
            : min(overScrolledExtent, layoutExtentSize),
      );
    } else {
      /// 如果不想显示可以直接设置为 zero
      geometry = SliverGeometry.zero;
    }
    setChildParentData(child, constraints, geometry);
  }
}
