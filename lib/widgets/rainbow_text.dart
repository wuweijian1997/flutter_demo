import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class RainbowText extends StatefulWidget {
  final List<Color> colors;
  final String text;
  final bool loop;
  final TextStyle style;

  const RainbowText({
    Key? key,
    this.colors = const [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.brown,
      Colors.purple,
    ],
    required this.text,
    this.loop = true,
    this.style = const TextStyle(fontSize: 20),
  }) : super(key: key);

  @override
  _RainbowTextState createState() => _RainbowTextState();
}

class _RainbowTextState extends State<RainbowText>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Size _size = Size.zero;

  bool get loop => widget.loop;

  String get text => widget.text;

  TextStyle get style => widget.style;

  List<Color> get colors => widget.colors;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
    );
    if (loop) {
      controller.repeat(min: 0, max: 1, period: const Duration(milliseconds: 1000));
    }
  }

  @override
  void didUpdateWidget(RainbowText oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _getSize(Size value) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _size = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, Widget? child) {
        double width = _size.width;
        TextStyle textStyle = style;
        if (colors.isNotEmpty && width > 0) {
          Rect rect = Rect.fromLTWH(controller.value * width, 0, width, 0);
          Shader shader = LinearGradient(
            colors: colors,
            tileMode: TileMode.repeated,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(rect);

          Paint foreground = Paint();
          foreground.shader = shader;
          textStyle = textStyle.copyWith(foreground: foreground);
        }
        return GetSize(
          onSize: _getSize,
          child: Text(
            text,
            style: textStyle,
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
