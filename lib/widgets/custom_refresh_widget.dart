import 'dart:math';

import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomRefreshWidget extends SingleChildRenderObjectWidget {
  const CustomRefreshWidget({Key key, Widget child})
      : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SimpleRefreshSliver();
  }
}

class SimpleRefreshSliver extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    final SliverConstraints constraints = this.constraints;
    final bool active = constraints.overlap < 0.0;
    /// 头部滑动的距离
    final double overScrolledExtent =
    constraints.overlap < 0.0 ? constraints.overlap.abs() : 0.0;
    double layoutExtent = max(overScrolledExtent, 50);
    ///将 SliverConstraints转化为BoxConstraints对child进行layout
    child.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    if (active) {
      geometry = SliverGeometry(
        scrollExtent: layoutExtent,
        /// RefreshWidget 的绘制起始位置
        paintOrigin: min(overScrolledExtent - layoutExtent, 0),
        paintExtent: max(max(child.size.height, layoutExtent) ,0.0,),
        maxPaintExtent: max(max(child.size.height, layoutExtent) ,0.0,),
        /// 布局占位
        layoutExtent: min(overScrolledExtent, layoutExtent),
      );
    } else {
      /// 如果不想显示可以直接设置为 zero
      geometry = SliverGeometry.zero;
    }
    setChildParentData(child, constraints, geometry);
  }
}
