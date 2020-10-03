import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class ToastPage extends StatelessWidget {
  static const String rName = "Toast";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(
              onClick: () => ToastUtil.show(msg: "Hello World", context: context),
              child: Text('msg'),
            ),
            Button(
              onClick: () {
                ToastUtil.showLoading(context: context);
                Future.delayed(Duration(milliseconds: 3000),() {
                  ToastUtil.hiddenLoading();
                });
              },
              child: Text('loading'),
            ),
          ],
        ),
      ),
    );
  }
}
