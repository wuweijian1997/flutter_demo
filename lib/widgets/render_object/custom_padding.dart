import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomPadding extends SingleChildRenderObjectWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  CustomPadding({
    Key key,
    Widget child,
    @required this.padding,
    this.margin = const EdgeInsets.all(0),
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderPadding(
      padding: padding,
      margin: margin,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderPadding renderObject) {
    renderObject
      ..padding = padding
      ..margin = margin;
  }
}

class _RenderPadding extends RenderShiftedBox {
  _RenderPadding({
    RenderBox child,
    TextDirection textDirection,
    @required EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
  })  : _textDirection = textDirection,
        _padding = padding,
        _margin = margin,
        _resolvedPadding = padding.resolve(textDirection),
        _resolvedMargin = margin.resolve(textDirection),
        super(child);

  EdgeInsets _resolvedPadding;
  EdgeInsets _resolvedMargin;
  EdgeInsetsGeometry _margin;
  TextDirection _textDirection;
  EdgeInsetsGeometry _padding;

  TextDirection get textDirection => _textDirection;

  EdgeInsetsGeometry get padding => _padding;

  set padding(EdgeInsetsGeometry value) {
    if (_padding == value) return;
    _padding = value;
    _resolvedPadding = _padding.resolve(_textDirection);
    markNeedsLayout();
  }

  EdgeInsetsGeometry get margin => _margin;

  set margin(EdgeInsetsGeometry value) {
    if (_margin == value) return;
    _margin = value;
    _resolvedMargin = _margin.resolve(_textDirection);
    markNeedsLayout();
  }

  ///最小宽度
  @override
  double computeMinIntrinsicWidth(double height) {
    final double totalHorizontalPadding =
        _resolvedPadding.left + _resolvedPadding.right;
    final double totalVerticalPadding =
        _resolvedPadding.top + _resolvedPadding.bottom;
    if (child != null)
      return child
              .getMinIntrinsicWidth(max(.0, height - totalVerticalPadding)) +
          totalHorizontalPadding;
    return totalHorizontalPadding;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double totalHorizontalPadding =
        _resolvedPadding.left + _resolvedPadding.right;
    final double totalVerticalPadding =
        _resolvedPadding.top + _resolvedPadding.bottom;
    if (child != null)
      return child
              .getMaxIntrinsicWidth(max(.0, height - totalVerticalPadding)) +
          totalHorizontalPadding;
    return totalHorizontalPadding;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final double totalHorizontalPadding =
        _resolvedPadding.left + _resolvedPadding.right;
    final double totalVerticalPadding =
        _resolvedPadding.top + _resolvedPadding.bottom;
    if (child != null)
      return child
              .getMinIntrinsicHeight(max(0.0, width - totalHorizontalPadding)) +
          totalVerticalPadding;
    return totalVerticalPadding;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final double totalHorizontalPadding =
        _resolvedPadding.left + _resolvedPadding.right;
    final double totalVerticalPadding =
        _resolvedPadding.top + _resolvedPadding.bottom;
    if (child != null)
      return child
              .getMaxIntrinsicHeight(max(0.0, width - totalHorizontalPadding)) +
          totalVerticalPadding;
    return totalVerticalPadding;
  }

  // 411 683
  // 371 643
  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    if (child == null) {
      size = constraints.constrain(Size(
        _resolvedPadding.left + _resolvedPadding.right + _resolvedMargin.left + _resolvedMargin.right,
        _resolvedPadding.top + _resolvedPadding.bottom + _resolvedMargin.top + _resolvedMargin.bottom,
      ));
      return;
    }
    final BoxConstraints innerConstraints =
        constraints.deflate(_resolvedPadding).deflate(_resolvedMargin);

    ///给子节点的大小约束.
    child.layout(innerConstraints, parentUsesSize: true);
    final BoxParentData childParentData = child.parentData as BoxParentData;

    ///控制子组件在父组件的位置.
    childParentData.offset =
        Offset(_resolvedPadding.left + _resolvedMargin.left, _resolvedPadding.top + _resolvedMargin.top);
    size = constraints.constrain(Size(
      _resolvedPadding.left + child.size.width + _resolvedPadding.right + _resolvedMargin.left + _resolvedMargin.right,
      _resolvedPadding.top + child.size.height + _resolvedPadding.bottom + _resolvedMargin.top + _resolvedMargin.bottom,
    ));
  }
}
