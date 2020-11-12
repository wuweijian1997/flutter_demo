import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class RainbowTextPage extends StatelessWidget {
  static const String rName = 'RainbowText';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RainbowText(
            text: "Hello World!",
          ),
          HollowText(
            text: "Hello World",
          )
        ],
      ),
    );
  }
}

