import 'package:demo/clipper/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class AnimationRoutePage extends StatefulWidget {
  static const rName = 'animationRoutePage';

  @override
  _AnimationRoutePageState createState() => _AnimationRoutePageState();
}

class _AnimationRoutePageState extends State<AnimationRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.red,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: _transitionsBuilder,
              pageBuilder: (ctx, animation1, animation2) {
                return ConstDemo();
              }));
        },
      ),
    );
  }

  Widget _transitionsBuilder(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return ClipOval(
          clipper: CircularClipper(percentage: animation?.value, offset: Offset(constraints.maxWidth /2, constraints.minHeight / 2)),
          child: child,
        );
      },
    );
  }
}
