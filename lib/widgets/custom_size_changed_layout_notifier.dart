
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomSizeChangedLayoutNotification extends SizeChangedLayoutNotification {
  final Size size;

  CustomSizeChangedLayoutNotification(this.size);
}

class CustomSizeChangedLayoutNotifier extends SingleChildRenderObjectWidget {
  const CustomSizeChangedLayoutNotifier({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  @override
  _RenderSizeChangedWithCallback createRenderObject(BuildContext context) {
    return _RenderSizeChangedWithCallback(
        onLayoutChangedCallback: (Size size) {
          CustomSizeChangedLayoutNotification(size).dispatch(context);
        }
    );
  }
}

class _RenderSizeChangedWithCallback extends RenderProxyBox {
  _RenderSizeChangedWithCallback({
    RenderBox child,
    @required this.onLayoutChangedCallback,
  }) : assert(onLayoutChangedCallback != null),
        super(child);

  final ValueChanged<Size> onLayoutChangedCallback;

  Size _oldSize;

  @override
  void performLayout() {
    super.performLayout();
    if (size != _oldSize)
      onLayoutChangedCallback(size);
    _oldSize = size;
  }
}
