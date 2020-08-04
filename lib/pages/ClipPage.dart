import 'package:flutter/material.dart';

class ClipPage extends StatelessWidget {
  static const rName = 'ClipPage';

  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.network(
        "http://ppic.meituba.com:84/uploads/allimg/2018/11/21/7356.jpg",
      width: 200,
      height: 200,
      fit: BoxFit.fill,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('ClipPage'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              //不剪裁
              avatar,
              //剪裁为圆形
              ClipOval(
                child: avatar,
              ),
              //剪裁为圆角矩形
              ClipRRect(
                child: avatar,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
