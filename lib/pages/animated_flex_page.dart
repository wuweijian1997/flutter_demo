import 'package:animated_flex/animated_flex.dart';
import 'package:flutter/material.dart';

class AnimatedFlexPage extends StatefulWidget {
  static const rName = 'AnimatedFlexPage';

  @override
  _AnimatedFlexPageState createState() => _AnimatedFlexPageState();
}

class _AnimatedFlexPageState extends State<AnimatedFlexPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: SingleChildScrollView(
        child: AnimatedFlex(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Hello World',
                    style: TextStyle(
                        fontSize: 30
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                color: Colors.pink,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                color: Colors.yellow,
              ),
            ),
          ]
        ),
      ),
    );
  }

}
