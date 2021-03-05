import 'dart:math';

import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

abstract class TipsBubbleDelegate {
  final Widget child;
  final VoidCallback? onTap;

  TipsBubbleDelegate({required this.child, this.onTap});

  build(
    BuildContext context,
    Size size,
    Offset offset,
    TipsDirection direction,
    OperationTipsController operationTipsController,
  );
}

class DefaultTipsBubbleDelegate extends TipsBubbleDelegate {
  final Color color;
  final double radius;
  final double tail;
  final double distance;

  double _left = 0, _top = 0;
  Size? _tipsBubbleSize;
  TipsDirection? _direction;
  BoxConstraints? _constraints;

  DefaultTipsBubbleDelegate({
    Key? key,
    this.color = Colors.black,
    required Widget child,
    VoidCallback? onTap,
    this.radius = 10,
    this.tail = 10,
    this.distance = 10,
  }) : super(child:child, onTap: onTap);

  @override
  build(
    BuildContext context,
    Size size,
    Offset offset,
    TipsDirection direction,
    OperationTipsController operationTipsController,
  ) {
    return GestureDetector(
      onTap: operationTipsController.close,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (_, BoxConstraints constraints) {
            if (_constraints != constraints) {
              _constraints = constraints;
            }
            return Stack(
              children: [
                StatefulBuilder(
                  builder: (_, StateSetter setState) {
                    return buildBody(size, offset, direction,
                        operationTipsController, setState);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  buildBody(
    Size size,
    Offset offset,
    TipsDirection direction,
    OperationTipsController operationTipsController,
    StateSetter setState,
  ) {
    if (_tipsBubbleSize == null) {
      return NotificationListener<CustomSizeChangedLayoutNotification>(
        onNotification: (CustomSizeChangedLayoutNotification notification) {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            setState(() {
              _tipsBubbleSize = notification.size;
              calculatePosition(direction, size, offset);
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
        left: _left,
        top: _top,
        child: buildBubble(_direction!, operationTipsController),
      );
    }
  }

  Widget buildBubble(
    TipsDirection direction,
    OperationTipsController operationTipsController,
  ) {
    Alignment alignment;
    switch (direction) {
      case TipsDirection.top:
        alignment = Alignment.bottomCenter;
        break;
      case TipsDirection.left:
        alignment = Alignment.centerRight;
        break;
      case TipsDirection.bottom:
        alignment = Alignment.topCenter;
        break;
      case TipsDirection.right:
        alignment = Alignment.centerLeft;
        break;
      default:
        alignment = Alignment.center;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        operationTipsController.close();
        onTap?.call();
      },
      child: ScaleTransition(
        scale: operationTipsController.animation,
        alignment: alignment,
        child: FadeTransition(
          opacity: operationTipsController.animation,
          child: PhysicalShape(
            color: color,
            clipper: TipsBubbleClipper(
              radius: radius,
              tail: tail,
              direction: direction,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  calculatePosition(TipsDirection direction, Size size, Offset offset) {
    switch (direction) {
      case TipsDirection.vertical:
        if (_constraints!.maxHeight - size.height - offset.dy > offset.dy) {
          _direction = TipsDirection.bottom;
        } else {
          _direction = TipsDirection.top;
        }
        break;
      case TipsDirection.horizontal:
        if (_constraints!.maxWidth - size.width - offset.dx > offset.dx) {
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
        _left = offset.dx + size.width / 2 - _tipsBubbleSize!.width / 2;
        _top = offset.dy - _tipsBubbleSize!.height - distance;
        break;
      case TipsDirection.left:
        _left = offset.dx - _tipsBubbleSize!.width - distance;
        _top = offset.dy + (size.height - _tipsBubbleSize!.height) / 2;
        break;
      case TipsDirection.bottom:
        _left = offset.dx + size.width / 2 - _tipsBubbleSize!.width / 2;
        _top = offset.dy + size.height + distance;
        break;
      case TipsDirection.right:
        _left = offset.dx + distance + size.width;
        _top = offset.dy + (size.height - _tipsBubbleSize!.height) / 2;
        break;
      default:
    }
  }
}

class TipsBubbleClipper extends CustomClipper<Path> {
  final double radius;
  final double tail;
  final TipsDirection direction;

  TipsBubbleClipper({
    required this.radius,
    required this.tail,
    this.direction = TipsDirection.bottom,
  });

  double get diameter => radius * 2.0;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(radius, 0);
    if (direction == TipsDirection.bottom) {
      tipTop(path, size);
    }
    path.lineTo(size.width - radius, 0);
    path.arcTo(Rect.fromLTWH(size.width - diameter, 0, diameter, diameter),
        degreeToRadians(-90), degreeToRadians(90), false);
    if (direction == TipsDirection.left) {
      tipRight(path, size);
    }
    path.lineTo(size.width, size.height - radius);
    path.arcTo(
      Rect.fromLTWH(
        size.width - diameter,
        size.height - diameter,
        diameter,
        diameter,
      ),
      degreeToRadians(0),
      degreeToRadians(90),
      false,
    );
    if (direction == TipsDirection.top) {
      tipBottom(path, size);
    }
    path.lineTo(radius, size.height);
    path.arcTo(Rect.fromLTWH(0, size.height - diameter, diameter, diameter),
        degreeToRadians(90), degreeToRadians(90), false);

    if (direction == TipsDirection.right) {
      tipLeft(path, size);
    }
    path.lineTo(0, radius);
    path.arcTo(Rect.fromLTWH(0, 0, diameter, diameter), degreeToRadians(180),
        degreeToRadians(90), false);

    path.close();
    return path;
  }

  tipTop(Path path, Size size) {
    path.lineTo((size.width - tail) / 2, 0);
    path.lineTo(size.width / 2, -tail / 2);
    path.lineTo(((size.width + tail) / 2), 0);
  }

  tipBottom(Path path, Size size) {
    path.lineTo((size.width + tail) / 2, size.height);
    path.lineTo(size.width / 2, size.height + tail / 2);
    path.lineTo(((size.width - tail) / 2), size.height);
  }

  tipRight(Path path, Size size) {
    path.lineTo(size.width, (size.height - tail) / 2);
    path.lineTo(size.width + tail / 2, size.height / 2);
    path.lineTo(size.width, (size.height + tail) / 2);
  }

  tipLeft(Path path, Size size) {
    path.lineTo(0, (size.height + tail) / 2);
    path.lineTo(-tail / 2, size.height / 2);
    path.lineTo(0, (size.height - tail) / 2);
  }

  @override
  bool shouldReclip(TipsBubbleClipper oldClipper) {
    return radius != oldClipper.radius ||
        tail != oldClipper.tail ||
        direction != oldClipper.direction;
  }

  double degreeToRadians(double degree) => (pi / 180) * degree;
}
