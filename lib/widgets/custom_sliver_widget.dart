import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomSliverWidget extends SingleChildRenderObjectWidget {
  const CustomSliverWidget({Key key, Widget child})
    : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomSliver();
  }
}

class CustomSliver extends RenderSliverSingleBoxAdapter {

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;
    ///将 SliverConstraints转化为BoxConstraints对child进行layout
    child.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child.size.width;
        break;
      case Axis.vertical:
        childExtent = child.size.height;
        break;
    }
    ///计算绘制大小
    final double paintedChildSize = calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    ///计算缓存大小
    final double cacheExtent = calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      paintOrigin: -100,
      // paintOrigin: constraints.scrollOffset,
      // visible: true,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent || constraints.scrollOffset > 0.0,
    );
    setChildParentData(child, constraints, geometry);
  }
}