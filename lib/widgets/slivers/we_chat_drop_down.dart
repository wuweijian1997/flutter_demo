import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum DropState {
  start,
  toStart,

  ///正在下拉
  drop,
  toEnd,

  ///
  end,
}

class WeChatDropDown extends SingleChildRenderObjectWidget {
  const WeChatDropDown({
    Key? key,
    Widget? child,
    required this.hasLayoutExtent,
    required this.layoutExtent,
    required this.bottomExtent,
  }) : super(key: key, child: child);

  final bool hasLayoutExtent;
  final double layoutExtent;
  final double bottomExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return WeChatDropDownSliver(
      hasLayoutExtent: hasLayoutExtent,
      refreshLayoutExtent: layoutExtent,
      bottomExtent: bottomExtent,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant WeChatDropDownSliver renderObject) {
    renderObject
      ..hasLayoutExtent = hasLayoutExtent
      ..childLayoutExtent = layoutExtent
      ..bottomExtent = bottomExtent;
  }
}

class WeChatDropDownSliver extends RenderSliverSingleBoxAdapter {
  bool _hasLayoutExtent;
  double _childLayoutExtent;
  double _bottomExtent;

  WeChatDropDownSliver({
    required bool hasLayoutExtent,
    required double refreshLayoutExtent,
    required double bottomExtent,
  })  : _hasLayoutExtent = hasLayoutExtent,
        _childLayoutExtent = refreshLayoutExtent,
        _bottomExtent = bottomExtent;

  double get bottomExtent => _bottomExtent;

  set bottomExtent(double value) {
    if (value == bottomExtent) return;
    _bottomExtent = value;
    markNeedsLayout();
  }

  set hasLayoutExtent(bool value) {
    if (value == _hasLayoutExtent) return;
    _hasLayoutExtent = value;
    lastOverlap = this.constraints.overlap;
    markNeedsLayout();
  }

  set childLayoutExtent(double value) {
    assert(value > 0);
    _childLayoutExtent = value;
    markNeedsLayout();
  }

  // 获取子组件大小
  double get childSize => child!.size.height;

  double layoutExtentOffsetCompensation = 0.0;

  double lastOverlap = 0;

  @override
  void performLayout() {
    final SliverConstraints constraints = this.constraints;
    final double layoutExtent = _hasLayoutExtent ? _childLayoutExtent : 0;
    if (layoutExtentOffsetCompensation != layoutExtent &&
        _hasLayoutExtent == false) {
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
    child!.layout(
        constraints.asBoxConstraints(
          ///最大范围: 布局的范围 +　滚动的范围
          maxExtent: layoutExtent + overScrolledExtent,
        ),
        parentUsesSize: true);
    if (active) {
      double _paintExtent = max(overScrolledExtent, layoutExtent);
      double _scrollExtent = layoutExtent;
      double _paintOrigin = min(constraints.overlap, 0);
      double _layoutExtent = max(
          lerpDouble(
              0,
              layoutExtent -
                  constraints.scrollOffset -
                  overScrolledExtent -
                  bottomExtent,
              (lastOverlap - constraints.overlap) / lastOverlap),
          0.0);
      /*Log.info(
          'scrollExtent: $_scrollExtent, paintExtent: $_paintExtent, '
          'paintOrigin: $_paintOrigin, layoutExtent: $_layoutExtent, '
          'scrollOffset: ${constraints.scrollOffset}, lastOverlap: $lastOverlap',
          StackTrace.current);*/
      geometry = SliverGeometry(
        scrollExtent: _scrollExtent,
        paintExtent: _paintExtent,
        maxPaintExtent: _paintExtent,
        paintOrigin: _paintOrigin,
        layoutExtent: _layoutExtent,
        hasVisualOverflow: true,
      );
    } else {
      /// 如果不想显示可以直接设置为 zero
      geometry = SliverGeometry.zero;
    }
  }

  double lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}
