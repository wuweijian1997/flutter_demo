import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayoutConstraints extends StatelessWidget {
  static const rName = 'LayoutConstraints';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 100,
            height: 100,
            color: Colors.white,
            child: FittedBox(
              child: Text('Hello World'),
            ) ,
        )
    );
  }
}
