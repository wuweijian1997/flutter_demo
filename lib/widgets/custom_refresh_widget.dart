import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomRefreshWidget extends SingleChildRenderObjectWidget {
  const CustomRefreshWidget({
    Key key,
    Widget child,
    this.hasLayoutExtent,
    this.refreshLayoutExtent,
  }) : super(key: key, child: child);

  final bool hasLayoutExtent;
  final double refreshLayoutExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SimpleRefreshSliver(
      hasLayoutExtent: hasLayoutExtent,
      refreshLayoutExtent: refreshLayoutExtent,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant SimpleRefreshSliver renderObject) {
    renderObject
      ..hasLayoutExtent = hasLayoutExtent
      ..refreshLayoutExtent = refreshLayoutExtent;
  }
}

class SimpleRefreshSliver extends RenderSliverSingleBoxAdapter {
  bool _hasLayoutExtent;
  double _refreshLayoutExtent;

  SimpleRefreshSliver({bool hasLayoutExtent, double refreshLayoutExtent})
      : _hasLayoutExtent = hasLayoutExtent,
        _refreshLayoutExtent = refreshLayoutExtent;

  set hasLayoutExtent(bool value) {
    assert(value != null);
    if (value == _hasLayoutExtent) return;
    _hasLayoutExtent = value;
    markNeedsLayout();
  }

  set refreshLayoutExtent(double value) {
    assert(value != null);
    assert(value > 0);
    _refreshLayoutExtent = value;
    markNeedsLayout();
  }

  // 获取子组件大小
  double get childSize => child.size.height;

  double layoutExtentOffsetCompensation = 0.0;

  @override
  void performLayout() {
    final SliverConstraints constraints = this.constraints;
    final double layoutExtent = _hasLayoutExtent ? _refreshLayoutExtent : 0;
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
          maxExtent: layoutExtent + overScrolledExtent,
        ),
        parentUsesSize: true);
    if (active) {
      final _layoutExtent =
          max(max(childSize, layoutExtent) - constraints.scrollOffset, 0.0);
      geometry = SliverGeometry(
        scrollExtent: layoutExtent,
        paintExtent: min(_layoutExtent, constraints.remainingPaintExtent),
        maxPaintExtent: _layoutExtent,
        paintOrigin: -overScrolledExtent - constraints.scrollOffset,
        layoutExtent: max(layoutExtent - constraints.scrollOffset, 0.0),
      );
    } else {
      /// 如果不想显示可以直接设置为 zero
      geometry = SliverGeometry.zero;
    }
  }
}
