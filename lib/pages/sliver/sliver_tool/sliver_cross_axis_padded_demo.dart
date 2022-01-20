import 'package:demo/const/index.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverCrossAxisPaddedDemo extends StatelessWidget {
  static const String rName = 'SliverCrossAxisPadded';

  const SliverCrossAxisPaddedDemo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverCrossAxisPadded(
            paddingStart: 24,
            paddingEnd: 48,
            textDirection: TextDirection.ltr,
            child: Const.buildSliverList(count: 20),
          )
        ],
      ),
    );
  }
}
