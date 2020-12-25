import 'dart:math';

import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

abstract class TipsBubbleDelegate {
  final Widget child;

  TipsBubbleDelegate(this.child);

  build(
    BuildContext context,
    TipsDirection direction,
    OperationTipsController operationTipsController,
  );
}

class DefaultTipsBubbleDelegate extends TipsBubbleDelegate {
  final Color color;
  final Widget child;
  final double radius;
  final double tail;
  final ValueGetter<bool> onTap;

  DefaultTipsBubbleDelegate({
    Key key,
    this.color = Colors.black,
    @required this.child,
    this.radius = 10,
    this.tail = 10,
    this.onTap,
  }): super(child);

  @override
  build(
    BuildContext context,
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
        operationTipsController.close();
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
}

class TipsBubbleClipper extends CustomClipper<Path> {
  final double radius;
  final double tail;
  final TipsDirection direction;

  TipsBubbleClipper({
    this.radius,
    this.tail,
    this.direction = TipsDirection.bottom,
  });

  double get diameter => radius * 2.0;

  @override
  Path getClip(Size size) {
    assert(radius != null);
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

