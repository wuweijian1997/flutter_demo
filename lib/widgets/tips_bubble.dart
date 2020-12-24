import 'dart:math';

import 'package:demo/widgets/operation_tips.dart';
import 'package:flutter/material.dart';

typedef BubbleBuilder = Widget Function(BuildContext context, Widget child);

class TipsBubble extends StatelessWidget {
  final Color color;
  final Widget child;
  final double radius;
  final double tail;
  final TipsDirection direction;
  final ValueGetter<bool> onTap;
  final BubbleBuilder builder;
  final OperationTipsController operationTipsController;

  TipsBubble({
    Key key,
    this.color = Colors.black,
    @required this.child,
    this.radius = 10,
    this.tail = 10,
    this.direction = TipsDirection.bottom,
    this.onTap,
    this.builder,
    this.operationTipsController,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body = PhysicalShape(
      color: color,
      clipper: TipsBubbleClipper(
        radius: radius,
        tail: tail,
        direction: direction,
      ),
      child: child,
    );
    if(builder != null) {
      return builder(context, body);
    }
    return _defaultBuilder(context, body);
  }

  _defaultBuilder(BuildContext context, Widget body) {
    return GestureDetector(
      onTap: () {
        print('_defaultBuilder');
        operationTipsController.hide();
        bool result = onTap?.call();
        if(result == true) {
          operationTipsController.hide();
        }
      },
      child: body,
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
    if (direction == TipsDirection.top) {
      tipTop(path, size);
    }
    path.lineTo(size.width - radius, 0);
    path.arcTo(Rect.fromLTWH(size.width - diameter, 0, diameter, diameter),
        degreeToRadians(-90), degreeToRadians(90), false);
    if (direction == TipsDirection.right) {
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
    if (direction == TipsDirection.bottom) {
      tipBottom(path, size);
    }
    path.lineTo(radius, size.height);
    path.arcTo(Rect.fromLTWH(0, size.height - diameter, diameter, diameter),
        degreeToRadians(90), degreeToRadians(90), false);

    if (direction == TipsDirection.left) {
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
