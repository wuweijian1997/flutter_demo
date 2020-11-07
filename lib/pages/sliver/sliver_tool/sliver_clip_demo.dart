import 'package:demo/const/index.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverClipDemo extends StatelessWidget {
  static const String rName = 'SliverClip';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverClip(
            clipOverlap: true,
            child: Const.buildSliverList(count: 20),
          )
        ],
      ),
    );
  }
}
