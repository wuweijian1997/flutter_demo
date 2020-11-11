import 'package:flutter/material.dart';

class RainbowText extends StatefulWidget {
  final List<Color> colors;
  final String text;
  final bool loop;

  RainbowText({Key key, this.colors, this.text, this.loop}) : super(key: key);

  @override
  _RainbowTextState createState() => _RainbowTextState();
}

class _RainbowTextState extends State<RainbowText> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
