import 'package:flutter/material.dart';

class ShadowDecoratedBox extends StatelessWidget {
  const ShadowDecoratedBox({Key? key}) : super(key: key);

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
              offset: const Offset(3, 3)
            )
          ]
        )),
        buildByDecoration(BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.grey.shade50,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 0,
              blurRadius: 16,
              offset: const Offset(3, 3)
            ),
            BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(3, 3)
            ),
            const BoxShadow(
                color: Colors.white,
                spreadRadius: 2,
                blurRadius: 16,
                offset: Offset(-3, -3)
            ),
            const BoxShadow(
                color: Colors.white,
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(-3, -3)
            ),

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
