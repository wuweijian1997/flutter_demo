import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class AnimationPhysicsPage extends StatefulWidget {
  static const rName = 'Physics Animation';

  @override
  _AnimationPhysicsPageState createState() => _AnimationPhysicsPageState();
}

class _AnimationPhysicsPageState extends State<AnimationPhysicsPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  final _spring = const SpringDescription(
    ///质量
    mass: 1,

    ///刚性,滚动收尾速度
    stiffness: 100,

    ///阻尼,摩擦力
    damping: 4,
  );

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        value: 0, lowerBound: -50, upperBound: 50, vsync: this);
    // controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, child) {
            print(controller.value);
            return Transform.translate(
              offset: Offset(controller.value, 0),
              child: child,
            );
          },
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final simulation = SpringSimulation(_spring, 0, 0, 400);
          controller.animateWith(simulation);
        },
        child: Icon(Icons.replay),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
