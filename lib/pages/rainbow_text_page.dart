import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class RainbowTextPage extends StatelessWidget {
  static const String rName = 'RainbowText';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RainbowText(
          text: "Hello World!",
        ),
      ),
    );
  }
}

