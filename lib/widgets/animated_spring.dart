import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

typedef AnimatedSpringBuilder = Widget Function(
  BuildContext context,
  Widget child,
  Animation<double> animation,
);

enum SpringType {
  low,
  medium,
  high,
}

Widget _defaultAnimatedSpringBuilder(
  BuildContext context,
  Widget child,
  Animation<double> animation,
) {
  return Transform.translate(
    offset: Offset(animation.value, 0),
    child: child,
  );
}

class AnimatedSpring extends StatelessWidget {
  final AnimatedSpringController controller;
  final Widget child;
  final AnimatedSpringBuilder builder;

  AnimatedSpring({
    @required this.controller,
    @required this.child,
    this.builder = _defaultAnimatedSpringBuilder,
  }) : assert(builder != null);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation,
      builder: (BuildContext context, Widget child) {
        return builder(context, child, controller.animation);
      },
      child: child,
    );
  }
}

class AnimatedSpringController {
  AnimationController _controller;

  AnimatedSpringController(
    TickerProvider vsync, {
    double lowerBound = -100,
    double upperBound = 100,
  }) {
    _controller = AnimationController(
      vsync: vsync,
      value: 0,
      lowerBound: lowerBound,
      upperBound: upperBound,
    );
  }

  Animation<double> get animation => _controller.view;

  double get value => _controller.value;

  start({SpringType type = SpringType.medium}) {
    assert(type != null);
    SpringDescription spring;
    double velocity;

    switch (type) {
      case SpringType.low:
        spring = const SpringDescription(
          mass: 1,
          stiffness: 200,
          damping: 4,
        );
        velocity = 400;
        break;
      case SpringType.medium:
        spring = const SpringDescription(
          mass: 1,
          stiffness: 150,
          damping: 4,
        );
        velocity = 600;
        break;
      case SpringType.high:
        spring = const SpringDescription(
          mass: 1,
          stiffness: 100,
          damping: 4,
        );
        velocity = 800;
        break;
    }
    SpringSimulation simulation = SpringSimulation(spring, 0, 0, velocity);
    _controller.animateWith(simulation);
  }

  customStart(SpringDescription spring, double velocity) {
    assert(spring != null && velocity != null);
    SpringSimulation simulation = SpringSimulation(spring, 0, 0, velocity);
    _controller.animateWith(simulation);
  }

  dispose() {
    _controller.dispose();
  }
}
