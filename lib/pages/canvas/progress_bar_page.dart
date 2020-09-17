import 'package:demo/widgets/canvas/index.dart';
import 'package:flutter/material.dart';

class ProgressBarPage extends StatefulWidget {
  @override
  _ProgressBarPageState createState() => _ProgressBarPageState();
}

class _ProgressBarPageState extends State<ProgressBarPage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Color> color;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return RepaintBoundary(
          child: CustomPaint(
            painter: ProgressBarCanvasWidget(progress: controller.value),
            child: Center(
              child: Text(
                '${(controller.value * 100).ceil()} %',
                style: TextStyle(fontSize: 50, color: Colors.pink),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
