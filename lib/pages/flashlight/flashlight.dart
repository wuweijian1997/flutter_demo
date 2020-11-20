import 'package:demo/pages/flashlight/light_painter.dart';
import 'package:flutter/material.dart';
import 'delegate/index.dart';

class Flashlight extends StatelessWidget {
  final Widget child;
  final FlashlightDelegate delegate;
  final bool alwaysOn;
  final Duration duration;
  final Gradient nightGradient;

  Flashlight({
    @required this.child,
    this.alwaysOn = false,
    this.duration = const Duration(milliseconds: 500),
    this.delegate = const DefaultFlashlightDelegate(),
    this.nightGradient = const LinearGradient(
      colors: [Colors.black, Colors.black],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ShaderMask(
          blendMode: BlendMode.srcOut,
          shaderCallback: (bounds) {
            return nightGradient.createShader(bounds);
          },
          child: _FlashlightDrag(
            duration: duration,
            alwaysOn: alwaysOn,
            delegate: delegate,
          ),
        )
      ],
    );
  }
}

class _FlashlightDrag extends StatefulWidget {
  final Duration duration;
  final bool alwaysOn;
  final FlashlightDelegate delegate;

  _FlashlightDrag({this.duration, this.alwaysOn, this.delegate});

  @override
  __FlashlightDragState createState() => __FlashlightDragState();
}

class __FlashlightDragState extends State<_FlashlightDrag>
    with SingleTickerProviderStateMixin {
  Offset touchOffset;
  Offset animationOffset;
  Offset panStartOffset;
  AnimationController animationController;

  Duration get duration => widget.duration;

  bool get alwaysOn => widget.alwaysOn;

  FlashlightDelegate get delegate => widget.delegate;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: duration, vsync: this);
    animationController.addListener(() {
      if (panStartOffset != null) {
        setState(() {
          animationOffset = Offset.lerp(
            panStartOffset,
            touchOffset,
            animationController.value,
          );
        });
      }
    });
  }

  @override
  void didUpdateWidget(_FlashlightDrag oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.alwaysOn != alwaysOn) {
      touchOffset = null;
    }
  }

  onPanStart(DragStartDetails details) {
    setState(() {
      if (touchOffset != null) {
        panStartOffset = touchOffset;
        animationController.forward(from: 0).whenCompleteOrCancel(() {
          setState(() {
            animationOffset = null;
            panStartOffset = null;
          });
        });
      }
      touchOffset = details.localPosition;
    });
  }

  onPanUpdate(DragUpdateDetails details) {
    setState(() {
      touchOffset = details.localPosition;
    });
  }

  onPanEnd(DragEndDetails details) {
    if (alwaysOn == false) {
      setState(() {
        touchOffset = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onPanStart: onPanStart,
          onPanUpdate: onPanUpdate,
          onPanEnd: onPanEnd,
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Colors.transparent,
            child: CustomPaint(
              painter: LightPainter(
                delegate: delegate,
                touchOffset: animationOffset ?? touchOffset,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
