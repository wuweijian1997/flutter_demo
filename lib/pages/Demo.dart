import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  static const rName = 'Demo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提示'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Text("Demo"),
        ),
      ),
    );
  }
}
