import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomAlign extends SingleChildRenderObjectWidget {
  CustomAlign({
    Key key,
    Widget child,
    this.alignment,
    this.widthFactor,
    this.heightFactor,
  }) : super(key: key, child: child);
  final AlignmentGeometry alignment;
  final double widthFactor;
  final double heightFactor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderPositionedBox();
  }
}

class _RenderPositionedBox extends RenderAligningShiftedBox {
  _RenderPositionedBox({
    RenderBox child,
    double widthFactor,
    double heightFactor,
    AlignmentGeometry alignment = Alignment.center,
    TextDirection textDirection,
  })  : _widthFactor = widthFactor,
        _heightFactor = heightFactor,
        super(
          child: child,
          alignment: alignment,
          textDirection: textDirection,
        );

  double _widthFactor;
  double _heightFactor;

  double get widthFactor => _widthFactor;

  set widthFactor(double value) {
    if (_widthFactor == value) return;
    _widthFactor = value;
    markNeedsLayout();
  }

  double get heightFactor => _heightFactor;

  set heightFactor(double value) {
    if (_heightFactor == value) return;
    _heightFactor = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final bool shrinkWrapWidth =
        _widthFactor != null || constraints.maxWidth == double.infinity;
    final bool shrinkWrapHeight =
        _heightFactor != null || constraints.maxHeight == double.infinity;

    if (child != null) {
      child.layout(constraints.loosen(), parentUsesSize: true);
      size = constraints.constrain(
        Size(
          shrinkWrapWidth
              ? child.size.width * (_widthFactor ?? 1.0)
              : double.infinity,
          shrinkWrapHeight
              ? child.size.height * (_heightFactor ?? 1.0)
              : double.infinity,
        ),
      );
    } else {
      size = constraints.constrain(
        Size(
          shrinkWrapWidth ? .0 : double.infinity,
          shrinkWrapHeight ? .0 : double.infinity,
        ),
      );
    }
  }
}
