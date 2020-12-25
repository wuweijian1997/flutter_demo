import 'package:demo/widgets/index.dart';
import 'package:demo/widgets/tips_bubble_delegate.dart';
import 'package:flutter/material.dart';

enum TipsDirection {
  top,
  left,
  bottom,
  right,
  vertical,
  horizontal,
}

typedef OperationTipsBuilder = Widget Function(
  BuildContext context,
  Widget child,
  OperationTipsController operationTipsController,
);

Widget _defaultOperationTipsBuilder(
  BuildContext context,
  Widget child,
  OperationTipsController operationTipsController,
) {
  return WillPopScope(
    onWillPop: () {
      if (operationTipsController.isActive) {
        operationTipsController.close();
        return Future.value(false);
      }
      return Future.value(true);
    },
    child: GestureDetector(
      child: child,
      onLongPress: () {
        operationTipsController.open();
      },
    ),
  );
}

class OperationTips extends StatefulWidget {
  final Widget child;
  final Widget tipsBubble;
  final OperationTipsController operationTipsController;
  final OperationTipsBuilder builder;
  final TipsDirection direction;
  final VoidCallback onTap;

  OperationTips({
    Key key,
    @required this.child,
    this.tipsBubble,
    this.operationTipsController,
    this.builder = _defaultOperationTipsBuilder,
    this.direction = TipsDirection.vertical,
    this.onTap,
  })  : assert(operationTipsController != null || tipsBubble != null),
        super(key: key);

  @override
  _OperationTipsState createState() => _OperationTipsState();
}

class _OperationTipsState extends State<OperationTips>
    with SingleTickerProviderStateMixin {
  OperationTipsController operationTipsController;
  Animation<double> scale;
  Animation<double> opacity;
  Size size = Size.zero;

  OperationTipsBuilder get builder => widget.builder;

  Widget get tipsBubble => widget.tipsBubble;

  @override
  void initState() {
    super.initState();
    operationTipsController = widget.operationTipsController ??
        OperationTipsController(
          vsync: this,
          direction: widget.direction,
          delegate: DefaultTipsBubbleDelegate(
            child: tipsBubble,
            onTap: widget.onTap,
          ),
        );
  }

  Widget get child => widget.child;

  @override
  Widget build(BuildContext context) {
    assert(child != null);
    operationTipsController._context = context;
    if (operationTipsController._context == null) {
      operationTipsController._context = context;
    }
    return builder(context, child, operationTipsController);
  }

  @override
  void dispose() {
    operationTipsController.dispose();
    super.dispose();
  }
}

class OperationTipsController {
  BuildContext _context;
  OverlayEntry _overlayEntry;
  AnimationController _animationController;
  final TipsBubbleDelegate delegate;
  final TipsDirection direction;

  Animation<double> get animation => _animationController?.view;

  bool get isActive => _overlayEntry != null;

  OperationTipsController({
    @required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 200),
    @required this.delegate,
    this.direction = TipsDirection.vertical,
  }) {
    if (vsync != null) {
      _animationController =
          AnimationController(vsync: vsync, duration: duration);
    }
  }

  close({bool isAnimated = true}) async {
    if (_overlayEntry == null) return;
    if (isAnimated == true) {
      await _animationController.reverse();
    }
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  open() {
    if (_overlayEntry != null) return;
    assert(_context != null);
    RenderBox renderBox = _context.findRenderObject();
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(builder: (_) {
      return delegate.build(_context, size, offset, direction, this);
    });
    Overlay.of(_context).insert(_overlayEntry);
    _animationController?.forward();
  }

  dispose() {
    close(isAnimated: false);
    _animationController.dispose();
  }
}
