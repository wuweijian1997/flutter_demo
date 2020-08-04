import 'package:flutter/material.dart';

class ConstrainedBoxPage extends StatelessWidget {
  static const rName = 'ConstrainedBoxPage';

  Widget _buildRedBox() {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('ConstrainedBox'),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity, //宽度尽可能大
                minHeight: 50.0,  //最小高度为50px
              ),
              child: _buildRedBox(),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tight(Size(100, 100)),
              child: _buildRedBox(),
            ),
            AspectRatio(
              //比例尺寸限制,宽 / 高 = 2
              aspectRatio: 2,
              child: _buildRedBox(),
            )
          ],
        ),
      ),
    );
  }
}
