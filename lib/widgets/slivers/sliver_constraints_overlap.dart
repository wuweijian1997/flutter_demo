import 'package:demo/model/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverConstraintsOverlap extends SingleChildRenderObjectWidget {
  final ValueNotifier<SliverModel> constraintsNotifier;
  SliverConstraintsOverlap({Key key, Widget child, this.constraintsNotifier}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return ConstraintsOverlap(constraintsNotifier: constraintsNotifier);
  }

}

class ConstraintsOverlap extends RenderSliverSingleBoxAdapter {
  ValueNotifier<SliverModel> constraintsNotifier;

  ConstraintsOverlap({this.constraintsNotifier});

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;
    constraintsNotifier?.value = SliverModel(overlap: constraints.overlap, scrollOffset: constraints.scrollOffset);
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
    final double paintedChildSize = calculatePaintOffset(constraints, from: 0.0, to: childExtent);

    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      maxPaintExtent: childExtent,
    );
    setChildParentData(child, constraints, geometry);
  }
}
