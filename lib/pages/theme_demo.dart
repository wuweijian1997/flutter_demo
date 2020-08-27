import 'package:flutter/material.dart';

class ThemeDemo extends StatelessWidget {
  static String rName = 'ThemeDemo';

  @override
  Widget build(BuildContext context) {
    ///局部主题,不会覆盖顶层Theme
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.pink,
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('Theme Demo'),),
        body: Container(
          child: Text('Theme Demo'),
        ),
      ),
    );
  }
}
