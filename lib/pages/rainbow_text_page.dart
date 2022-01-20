import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class RainbowTextPage extends StatelessWidget {
  static const String rName = 'RainbowText';

  const RainbowTextPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
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

