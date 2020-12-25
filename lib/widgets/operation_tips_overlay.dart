import 'package:demo/widgets/index.dart';
import 'package:demo/widgets/tips_bubble_delegate.dart';
import 'package:flutter/material.dart';

class OperationTipsOverlay extends StatefulWidget {
  final TipsBubbleDelegate delegate;
  final TipsDirection direction;
  final Offset offset;
  final Size size;
  final OperationTipsController operationTipsController;
  final double distance;

  OperationTipsOverlay({
    Key key,
    @required this.delegate,
    @required this.offset,
    @required this.size,
    @required this.operationTipsController,
    this.direction = TipsDirection.vertical,
    this.distance = 10,
  }) : super(key: key);

  @override
  _OperationTipsOverlayState createState() => _OperationTipsOverlayState();
}

class _OperationTipsOverlayState extends State<OperationTipsOverlay> {
  Animation<double> scale;
  Animation<double> opacity;
  Size tipsBubbleSize;
  double left = 0;
  double top = 0;
  BoxConstraints _constraints;
  TipsDirection _direction;

  Size get size => widget.size;

  Offset get offset => widget.offset;

  double get distance => widget.distance;

  TipsBubbleDelegate get delegate => widget.delegate;

  TipsDirection get direction => widget.direction;

  OperationTipsController get operationTipsController =>
      widget.operationTipsController;

  calculatePosition() {
    switch (direction) {
      case TipsDirection.vertical:
        if(_constraints.maxHeight - size.height - offset.dy > offset.dy) {
          _direction = TipsDirection.bottom;
        } else {
          _direction = TipsDirection.top;
        }
        break;
      case TipsDirection.horizontal:
        if(_constraints.maxWidth - size.width - offset.dx > offset.dx) {
          _direction = TipsDirection.right;
        } else {
          _direction = TipsDirection.left;
        }
        break;
      default:
        _direction = direction;
    }
    switch (_direction) {
      case TipsDirection.top:
        left = offset.dx + size.width / 2 - tipsBubbleSize.width / 2;
        top = offset.dy - tipsBubbleSize.height - distance;
        break;
      case TipsDirection.left:
        left = offset.dx - tipsBubbleSize.width - distance;
        top = offset.dy + (size.height - tipsBubbleSize.height) / 2;
        break;
      case TipsDirection.bottom:
        left = offset.dx + size.width / 2 - tipsBubbleSize.width / 2;
        top = offset.dy + size.height + distance;
        break;
      case TipsDirection.right:
        left = offset.dx + distance + size.width;
        top = offset.dy + (size.height - tipsBubbleSize.height) / 2;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: operationTipsController.close,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (_, BoxConstraints constraints) {
            if(_constraints != constraints) {
              _constraints = constraints;
            }
            return Stack(
              children: [
                buildTipsBubble(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildTipsBubble() {
    Widget child = delegate.build(context, _direction, operationTipsController);
    if (tipsBubbleSize == null) {
      return NotificationListener<CustomSizeChangedLayoutNotification>(
        onNotification: (CustomSizeChangedLayoutNotification notification) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            setState(() {
              tipsBubbleSize = notification.size;
              calculatePosition();
            });
          });
          return true;
        },
        child: CustomSizeChangedLayoutNotifier(
          child: Opacity(opacity: 0, child: child),
        ),
      );
    } else {
      return Positioned(
        left: left,
        top: top,
        child: child,
      );
    }
  }
}
