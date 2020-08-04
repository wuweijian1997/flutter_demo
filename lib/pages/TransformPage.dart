import 'package:flutter/material.dart';

class TransformPage extends StatelessWidget {
  static const rName = 'TransformPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TransformPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              color: Colors.black,
              child: Transform(
                //相对于坐标系原点的对齐方式
                alignment: Alignment.topRight,
                transform: Matrix4.skewY(0.3),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: Text("Apartment for rent!"),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Transform.translate(
                offset: Offset(20.0, 5.0),
                child: Text("Hello World 平移"),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Transform.rotate(
                angle: 90,
                child: Text("Hello World 旋转"),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Transform.scale(
                scale: 1.5,
                child: Text("Hello World 缩放"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
