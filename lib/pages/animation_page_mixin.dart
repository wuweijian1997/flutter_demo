import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class AnimationPageMixinPage extends StatefulWidget {
  static const rName = 'AnimationPageMixin';

  @override
  _AnimationPageMixinPageState createState() => _AnimationPageMixinPageState();
}

class _AnimationPageMixinPageState extends State<AnimationPageMixinPage>
    with TickerProviderStateMixin, AnimationPageMixin{

  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: animationPageDuration, vsync: this);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimationPageMixinPage'),
      ),
      body: ListView(
        children: initAnimation(widgetList, controller),
      ),
    );
  }

  List<Widget> widgetList = [
    Container(
      width: 200,
      height: 200,
      color: Colors.red,
    ),
    Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    ),
    Container(
      width: 200,
      height: 200,
      color: Colors.green,
    ),
    Container(
      width: 200,
      height: 200,
      color: Colors.pink,
    ),
    Container(
      width: 200,
      height: 200,
      color: Colors.yellow,
    ),
  ];
}
