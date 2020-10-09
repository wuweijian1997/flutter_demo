import 'package:demo/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoadingPage extends StatelessWidget {
  static const rName = 'CustomLoading';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CupertinoActivityIndicator(
              radius: 30,
            ),
            CustomLoading(radius: 30, color: Colors.blue, pointerRadius: 0,),
          ],
        ),
      ),
    );
  }
}
