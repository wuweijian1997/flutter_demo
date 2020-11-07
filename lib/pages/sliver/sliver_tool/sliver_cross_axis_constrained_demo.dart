import 'package:demo/const/index.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverCrossAxisConstrainedDemo extends StatelessWidget {
  static const String rName = 'SliverCrossAxisConstrained';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverCrossAxisConstrained(
            maxCrossAxisExtent: 700,
            child: Const.buildSliverList(count: 20),
          )
        ],
      ),
    );
  }
}
