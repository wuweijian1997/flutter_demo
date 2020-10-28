import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _RefreshSliver extends SingleChildRenderObjectWidget {
  const _RefreshSliver({
    Key key,
    Widget child,
    this.headerFloat = false,
    this.axisDirectionNotifier,
    this.hasLayoutExtent = false,
    @required this.infiniteRefresh,
    this.enableInfiniteRefresh = false,
    this.refreshIndicatorLayoutExtent = 0.0,
  })  : assert(refreshIndicatorLayoutExtent != null),
        assert(refreshIndicatorLayoutExtent >= 0.0),
        assert(hasLayoutExtent != null),
        super(key: key, child: child);

  /// 处于刷新模式时，指示器在静止状态下应在条子中占据的空间量。
  final double refreshIndicatorLayoutExtent;

  ///是否要占用空间
  final bool hasLayoutExtent;

  /// 是否开始无线刷新
  final bool enableInfiniteRefresh;

  ///无限加载回调
  final VoidCallback infiniteRefresh;

  /// 是否浮动
  final bool headerFloat;

  /// 列表方向
  final ValueNotifier<AxisDirection> axisDirectionNotifier;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderRefreshSliver(
      refreshIndicatorLayoutExtent: refreshIndicatorLayoutExtent,
      hasLayoutExtent: hasLayoutExtent,
      enableInfiniteRefresh: enableInfiniteRefresh,
      infiniteRefresh: infiniteRefresh,
      headerFloat: headerFloat,
      axisDirectionNotifier: axisDirectionNotifier,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderRefreshSliver renderObject) {
    renderObject
      ..headerFloat = headerFloat
      ..hasLayoutExtent = hasLayoutExtent
      ..enableInfiniteRefresh = enableInfiniteRefresh
      ..refreshIndicatorLayoutExtent = refreshIndicatorLayoutExtent;
  }
}

class _RenderRefreshSliver extends RenderSliverSingleBoxAdapter {
  _RenderRefreshSliver({
    @required headerFloat,
    @required this.infiniteRefresh,
    @required bool hasLayoutExtent,
    @required bool enableInfiniteRefresh,
    @required this.axisDirectionNotifier,
    @required double refreshIndicatorLayoutExtent,
  })  : _headerFloat = headerFloat,
        _hasLayoutExtent = hasLayoutExtent,
        _enableInfiniteRefresh = enableInfiniteRefresh,
        _refreshIndicatorLayoutExtent = refreshIndicatorLayoutExtent;

  /// 处于刷新模式时，指示器在静止状态下应在条子中占据的空间量。
  double _refreshIndicatorLayoutExtent;

  /// 列表方向
  final ValueNotifier<AxisDirection> axisDirectionNotifier;

  ///是否要占用空间
  bool _hasLayoutExtent;

  /// 是否开启无限刷新
  bool _enableInfiniteRefresh;

  /// Header浮动
  bool _headerFloat;

  /// 无限加载回调
  final VoidCallback infiniteRefresh;

  ///触发无限刷新
  bool _triggerInfiniteRefresh = false;

  double get childSize =>
      constraints.axis == Axis.vertical ? child.size.height : child.size.width;

  double layoutExtentOffsetCompensation = 0.0;

  @override
  void performLayout() {}

  @override
  double get centerOffsetAdjustment {
    ///Header 浮动时去掉越界
    if (headerFloat) {
      final RenderViewportBase renderView = parent;
      return max(0.0, -renderView.offset.pixels);
    }
    return super.centerOffsetAdjustment;
  }

  double get refreshIndicatorLayoutExtent => _refreshIndicatorLayoutExtent;

  set refreshIndicatorLayoutExtent(double value) {
    if (value == _refreshIndicatorLayoutExtent) return;
    _refreshIndicatorLayoutExtent = value;
    markNeedsLayout();
  }

  bool get hasLayoutExtent => _hasLayoutExtent;

  set hasLayoutExtent(bool value) {
    if (_hasLayoutExtent == value) return;
    _hasLayoutExtent = value;
    markNeedsLayout();
  }

  bool get enableInfiniteRefresh => _enableInfiniteRefresh;

  set enableInfiniteRefresh(bool value) {
    if (_enableInfiniteRefresh == value) return;
    _enableInfiniteRefresh = value;
    markNeedsLayout();
  }

  bool get headerFloat => _headerFloat;

  set headerFloat(bool value) {
    if (_headerFloat == value) return;
    _headerFloat = value;
    markNeedsLayout();
  }
}
