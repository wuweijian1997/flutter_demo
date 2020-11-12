
import 'package:flutter/material.dart';

class HollowText extends StatefulWidget {
  final String text;
  final List<Color> colors;

  HollowText({
    this.text,
    this.colors = const [
      Colors.red,
      Colors.green,
      Colors.green,
      Colors.blue,
      Colors.blue,
      Colors.red,
    ],
  });

  @override
  _HollowTextState createState() => _HollowTextState();
}

class _HollowTextState extends State<HollowText>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  List<Color> get colors => widget.colors;

  String get text => widget.text;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    controller.repeat(
      min: 0,
      max: 1,
      period: const Duration(milliseconds: 1000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, Widget child) {
        return ShaderMask(
          blendMode: BlendMode.srcOut,
          shaderCallback: (Rect bounds) {
            Rect rect = Rect.fromLTWH(bounds.left + bounds.width * controller.value, bounds.top, bounds.width / 2, bounds.height);
            return LinearGradient(
              colors: colors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.repeated,
            ).createShader(rect);
          },
          child: Container(
            width: double.infinity,
            height: 50,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              text,
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Colors.white,
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
