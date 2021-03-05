import 'dart:math';

import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverGeometryTest extends SingleChildRenderObjectWidget {
  const SliverGeometryTest({Key? key, Widget? child, required this.value})
      : super(key: key, child: child);

  final double value;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return GeometryTestSliver();
  }

  @override
  void updateRenderObject(
      BuildContext context, GeometryTestSliver renderObject) {
    renderObject..value = value;
  }
}

class GeometryTestSliver extends RenderSliverSingleBoxAdapter {
  double _value = .0;

  GeometryTestSliver({value}) : _value = value;

  double get value => _value;

  set value(double value) {
    if (value != _value) {
      _value = value;
      markNeedsLayout();
    }
  } //

  // 获取子组件大小
  double get childSize => child!.size.height;

  @override
  void performLayout() {
    final SliverConstraints constraints = this.constraints;
    if (_value != 0) {
      Log.info('value: $value, scrollOffset: ${constraints.scrollOffset}', StackTrace.current);
      geometry = SliverGeometry(
        scrollOffsetCorrection: -value - constraints.scrollOffset,
      );
      _value = 0;
      return;
    }
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double childExtent = childSize;
    final double paintExtent = max(childSize - constraints.scrollOffset, 0);
    final double paintOrigin = -constraints.scrollOffset;
    // final double layoutExtent = paintExtent;
    geometry = SliverGeometry(
      ///绘制起点
      paintOrigin: paintOrigin,
      scrollExtent: childExtent,
      paintExtent: paintExtent,
      maxPaintExtent: childExtent,
      // layoutExtent: layoutExtent,
    );
  }
}
