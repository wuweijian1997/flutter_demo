import 'package:demo/const/index.dart';
import 'package:demo/model/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class BubblePage extends StatefulWidget {
  final double width;
  final double height;

  BubblePage({this.width, this.height});

  @override
  _BubblePageState createState() => _BubblePageState();
}

class _BubblePageState extends State<BubblePage> with TickerProviderStateMixin {
  List<BubbleModel> list = [];
  AnimationController controller;
  Animation<Color> colorAnimation;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < Const.BUBBLE_COUNT; i++) {
      list.add(BubbleModel(width: widget.width, height: widget.height));
    }
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )
      ..addListener(() {
        rebuild();
      })
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.dismissed:
            controller.forward();
            break;
          case AnimationStatus.completed:
            controller.reverse();
            break;
          case AnimationStatus.forward:
            break;
          case AnimationStatus.reverse:
            break;
        }
      })
      ..forward();
    colorAnimation = ColorTween(begin: Const.BUBBLE_BG_COLOR_START, end: Const.BUBBLE_BG_COLOR_END).animate(controller);
  }

  rebuild() {
    setState(() {
      list.forEach((element) {
        if (element.offset.dy <= -element.radius) {
          element.init();
        }
        if (element.offset.dx <= element.radius) {
          element.moveOffset = Offset(-element.moveOffset.dx.abs(), element.moveOffset.dy);
        } else if (element.offset.dx >= widget.width - element.radius) {
          element.moveOffset = Offset(element.moveOffset.dx.abs(), element.moveOffset.dy);
        }
        element.moveOffset += element.accelerate;
        element.offset = element.offset - element.moveOffset;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.width, widget.height),
      painter: BubbleCanvasWidget(list: list, color: colorAnimation.value),
    );
  }
}
