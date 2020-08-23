import 'package:flutter/material.dart';

class UnKnowPage extends StatelessWidget {
  static String rName = 'UnKnow';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('错误页面'),),
      body: Container(
        child: Center(
          child: Text('错误页面'),
        ),
      ),
    );
  }
}
