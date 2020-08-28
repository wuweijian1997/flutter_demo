import 'dart:math';

import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class AnimationPageMixinPage extends StatefulWidget {
  static const rName = 'AnimationPageMixin';

  @override
  _AnimationPageMixinPageState createState() => _AnimationPageMixinPageState();
}

class _AnimationPageMixinPageState extends State<AnimationPageMixinPage>
    with TickerProviderStateMixin, AnimationPageMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: animationPageDuration, vsync: this);
    controller.forward();
  }

  @override
  buildTransform(Animation animation) {
    return Matrix4.translationValues( 20 * (1.0 - animation.value), 20 * (1.0 - animation.value), 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: ListView(
        children: initAnimation(widgetList, controller),
      ),
    );
  }

  List<Widget> widgetList = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        child: RaisedButton(
          onPressed: () {},
          color: Colors.blue,
          child: Icon(Icons.add, size: 50,),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.red,
        child: Image.asset(
          'assets/eat_cape_town_sm.jpg',
          height: 200,
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        color: Colors.green,
        child: Center(
          child: Text(
            'Hello World',
            style: TextStyle(
              fontSize: 30
            ),
          ),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        color: Colors.pink,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        color: Colors.yellow,
      ),
    ),
  ];
}
