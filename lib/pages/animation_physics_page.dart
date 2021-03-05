import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class AnimationPhysicsPage extends StatefulWidget {
  static const rName = 'Physics Animation';

  @override
  _AnimationPhysicsPageState createState() => _AnimationPhysicsPageState();
}

class _AnimationPhysicsPageState extends State<AnimationPhysicsPage>
    with SingleTickerProviderStateMixin {
  late SpringController controller;

  @override
  void initState() {
    super.initState();
    controller = SpringController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSpring(
          controller: controller,
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
              controller.start(type: SpringAnimationType.low);
            },
            child: Icon(Icons.one_k),
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              controller.start();
            },
            child: Icon(Icons.two_k),
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              controller.start(type: SpringAnimationType.high);
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
