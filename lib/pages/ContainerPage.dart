import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {
  static const rName = 'ContainerPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ContainerPage'),
      ),
      body: Container(
        //对齐方式
        alignment: Alignment.center,
        //容器内补白
        padding: EdgeInsets.all(20.0),
        //背景颜色
//        color: Colors.grey,
        //背景装饰
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.green),
        width: double.infinity,
        height: double.infinity,
        //容器大小限制条件
        constraints: BoxConstraints.tightForFinite(
            width: double.infinity, height: double.infinity),
        margin: EdgeInsets.all(10),
        child: Text('Hello World!'),
      ),
    );
  }
}
