import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class LineBorderPage extends StatelessWidget {
  static const rName = "LineBorderPage";

  const LineBorderPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LineBorderWidget(
          child: Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
