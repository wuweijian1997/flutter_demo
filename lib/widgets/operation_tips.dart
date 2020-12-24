import 'package:demo/widgets/tips_bubble.dart';
import 'package:flutter/material.dart';

enum TipsDirection {
  top,
  left,
  bottom,
  right,
}

class OperationTips extends StatefulWidget {
  final Widget child;
  final TipsDirection direction;
  final TipsBubble tipsBubble;
  final OperationTipsController operationTipsController;

  OperationTips({
    Key key,
    @required this.child,
    @required this.tipsBubble,
    this.operationTipsController,
    this.direction = TipsDirection.bottom,
  }) : super(key: key);

  @override
  _OperationTipsState createState() => _OperationTipsState();
}

class _OperationTipsState extends State<OperationTips> {
  OperationTipsController operationTipsController;
  AlignmentGeometry alignment;
  Animation<double> scale;
  Animation<double> opacity;
  Size size = Size.zero;

  Animation<double> get animation => operationTipsController.animation;

  @override
  void initState() {
    super.initState();
    operationTipsController = widget.operationTipsController;
    scale = animation.drive(Tween<double>(
      begin: .5,
      end: 1,
    ));
    opacity = animation.drive(Tween<double>(
      begin: .5,
      end: 1,
    ));
    switch (direction) {
      case TipsDirection.bottom:
        alignment = Alignment.bottomCenter;
        break;
      case TipsDirection.left:
        alignment = Alignment.centerLeft;
        break;
      case TipsDirection.right:
        alignment = Alignment.centerRight;
        break;
      case TipsDirection.top:
        alignment = Alignment.topCenter;
        break;
    }
  }

  Widget get child => widget.child;

  Widget get tipsBubble => widget.tipsBubble;

  TipsDirection get direction => widget.direction;

  @override
  Widget build(BuildContext context) {
    assert(child != null);
    return Stack(
      alignment: alignment,
      overflow: Overflow.visible,
      fit: StackFit.passthrough,
      children: [
        GestureDetector(
          child: child,
          onTap: () {
            print('build');
          },
          onLongPressStart: (_) {
            if (size != context.size) {
              setState(() {
                size = context.size;
              });
            }
          },
          onLongPress: () {
            operationTipsController.appear();
          },
        ),
        defaultTipsBubbleBuilder(animation, tipsBubble),
        Positioned(
          top: -100,
          child: GestureDetector(
            onTap: () {
              print("Hello World");
            },
            child: Container(
              color: Colors.blue,
              width: 100,
              height: 100,
            ),
          ),
        )
      ],
    );
  }

  Widget defaultTipsBubbleBuilder(Animation<double> animation, Widget child) {
    assert(animation != null);
    return Positioned(
      top: size.height + 10,
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return ScaleTransition(
            scale: scale,
            child: FadeTransition(
              opacity: opacity,
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}

class OperationTipsController {
  AnimationController _controller;

  Animation<double> get animation => _controller.view;

  OperationTipsController({
    @required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 200),
  }) {
    _controller = AnimationController(vsync: vsync, duration: duration);
  }

  hide() {
    _controller.reverse();
  }

  appear() {
    _controller.forward();
  }

  double get value => _controller?.value ?? 0;

  dispose() {
    _controller.dispose();
  }
}
