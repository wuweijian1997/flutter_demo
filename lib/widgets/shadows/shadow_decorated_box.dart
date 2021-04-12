import 'package:flutter/material.dart';

class ShadowDecoratedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildByDecoration(BoxDecoration(
          ///矩形
          shape: BoxShape.rectangle,
          // 圆形
          // shape: BoxShape.circle,
          color: Colors.lightBlue,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade700,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(3, 3)
            )
          ]
        )),
      ],
    );
  }


  Widget buildByDecoration(BoxDecoration decoration) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(width: 100, height: 100),
        decoration: decoration,
        margin: const EdgeInsets.all(20),
      ),
    );
  }
}
