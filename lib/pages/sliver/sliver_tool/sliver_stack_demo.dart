import 'package:demo/const/index.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverStackDemo extends StatelessWidget {
  static const String rName = 'SliverStack';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _SliverStackItem(),
          _SliverStackItem(),
        ],
      ),
    );
  }
}

class _SliverStackItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverStack(
      insetOnOverlap: false, // defaults to false
      children: <Widget>[
        SliverPositioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 8,
                  color: Colors.black26,
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Const.buildSliverList(count: 20),
      ],
    );
  }
}
