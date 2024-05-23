import 'package:demo/const/index.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class MultiSliverDemo extends StatelessWidget {
  static const String rName = 'MultiSliver';

  const MultiSliverDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          Section(
            infinite: false,
            title: 'First',
          ),
          Section(
            infinite: true,
            title: 'Second',
          ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final bool infinite;

  const Section({this.title = '', required this.infinite, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiSliver(pushPinnedChildren: true, children: [
      SliverPersistentHeader(
        pinned: true,
        delegate: _SectionHeader(extent: 100, title: title),
      ),
      if (!infinite)
        SliverAnimatedPaintExtent(
          duration: const Duration(milliseconds: 1000),
          child: Const.buildSliverList(count: 20),
        )
      else
        Const.buildSliverList(count: 20)
    ]);
  }
}

class _SectionHeader extends SliverPersistentHeaderDelegate {
  final String title;
  final double extent;

  _SectionHeader({required this.title, required this.extent});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.center,
      height: extent,
      color: Colors.blue,
      child: Text(title),
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => extent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
