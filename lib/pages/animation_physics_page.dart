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

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        value: 0, lowerBound: -100, upperBound: 100, vsync: this);
    // controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, child) {
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              final _spring = const SpringDescription(
                ///质量
                mass: 1,

                ///刚性,滚动收尾速度
                stiffness: 200,

                ///阻尼,摩擦力
                damping: 4,
              );
              final simulation = SpringSimulation(_spring, 0, 0, 400);
              controller.animateWith(simulation);
            },
            child: Icon(Icons.one_k),
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              final _spring = const SpringDescription(
                ///质量
                mass: 1,

                ///刚性,滚动收尾速度
                stiffness: 150,

                ///阻尼,摩擦力
                damping: 4,
              );
              final simulation = SpringSimulation(_spring, 0, 0, 600);
              controller.animateWith(simulation);
            },
            child: Icon(Icons.two_k),
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              final _spring = const SpringDescription(
                ///质量
                mass: 1,

                ///刚性,滚动收尾速度
                stiffness: 100,

                ///阻尼,摩擦力
                damping: 4,
              );
              final simulation = SpringSimulation(_spring, 0, 0, 800);
              controller.animateWith(simulation);
            },
            child: Icon(Icons.three_k),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
