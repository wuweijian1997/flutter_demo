import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

typedef AnimatedSpringBuilder = Widget Function(
  BuildContext context,
  Widget? child,
  Animation<double> animation,
);

enum SpringAnimationType {
  low,
  medium,
  high,
}

Widget _defaultAnimatedSpringBuilder(
  BuildContext context,
  Widget? child,
  Animation<double> animation,
) {
  return Transform.translate(
    offset: Offset(animation.value, 0),
    child: child,
  );
}

class AnimatedSpring extends StatelessWidget {
  final SpringController controller;
  final Widget child;
  final AnimatedSpringBuilder builder;

  AnimatedSpring({
    required this.controller,
    required this.child,
    this.builder = _defaultAnimatedSpringBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation,
      builder: (BuildContext context, Widget? child) {
        return builder(context, child, controller.animation);
      },
      child: child,
    );
  }
}

class SpringController {
  late AnimationController _controller;

  SpringController({
    required TickerProvider vsync,
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

  start({SpringAnimationType type = SpringAnimationType.medium}) {
    SpringDescription spring;
    double velocity;

    switch (type) {
      case SpringAnimationType.low:
        spring = const SpringDescription(
          mass: 1,
          stiffness: 200,
          damping: 5,
        );
        velocity = 400;
        break;
      case SpringAnimationType.medium:
        spring = const SpringDescription(
          mass: 1,
          stiffness: 150,
          damping: 5,
        );
        velocity = 600;
        break;
      case SpringAnimationType.high:
        spring = const SpringDescription(
          mass: 1,
          stiffness: 100,
          damping: 5,
        );
        velocity = 800;
        break;
    }
    SpringSimulation simulation = SpringSimulation(spring, 0, 0, velocity);
    startBySimulation(simulation);
  }

  startBySimulation(SpringSimulation simulation) {
    _controller.animateWith(simulation);
  }

  dispose() {
    _controller.dispose();
  }
}
