import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomSliverWidget extends SingleChildRenderObjectWidget {
  const CustomSliverWidget({Key? key, Widget? child})
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
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }

    ///计算绘制大小
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);

    ///计算缓存大小
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    geometry = SliverGeometry(
      /// sliver可以滚动的范围,可以认为是sliver的高度.
      scrollExtent: childExtent,

      /// 绘制范围

      paintExtent: paintedChildSize,

      /// 当前 sliver 占用了 SliverConstraints.remainingCacheExtent 多少像素值

      cacheExtent: cacheExtent,

      /// 最大绘制大小,必须 >= paintExtent

      maxPaintExtent: childExtent,

      /// 点击有效区域的大小,默认为paintExtent.

      hitTestExtent: paintedChildSize,

      /// 绘制起点(默认是0.0),是相对于sliver开始layout的起点而言的,
      /// 不会影响下一个的sliver的layoutExtent,会影响下一个sliver的paintExtent,
      /// 会覆盖下一个的sliver的paint
      paintOrigin: -100,

      ///布局范围,当前sliver的top到下一个sliver的距离,范围是[0, paintExtent],
      /// 默认是paintExtent,会影响下一个sliver的layout位置
      layoutExtent: 0,
      // paintOrigin: constraints.scrollOffset,
      // visible: true,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    setChildParentData(child!, constraints, geometry!);
  }
}
