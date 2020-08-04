import 'package:flutter/material.dart';

class PaddingPage extends StatelessWidget {
  static const rName = 'Padding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Padding'),
      ),
      body: Padding(
        //上下左右各添加16像素补白
        padding: EdgeInsets.all(18),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("EdgeInsets.only(left: 8.0)"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("EdgeInsets.symmetric(horizontal: 8.0)"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text("EdgeInsets.fromLTRB(20, 20, 20, 20)"),
            ),
          ],
        ),
      ),
    );
  }
}
