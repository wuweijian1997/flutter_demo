import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class MultiSliverDemo extends StatelessWidget {
  static const String rName = 'MultiSliver';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  Section({this.title = '', this.infinite});

  @override
  Widget build(BuildContext context) {
    return MultiSliver(pushPinnedChildren: true, children: [
      SliverPersistentHeader(
        pinned: true,
        delegate: _SectionHeader(extent: 100, title: title),
      ),
      if (!infinite)
        SliverAnimatedPaintExtent(
            duration: Duration(milliseconds: 1000),
            child: SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建列表项
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 10)],
                    child: Text('list item $index, height: 50'),
                  );
                },
                childCount: 20
              ),
            ))
      else
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              //创建列表项
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 10)],
                child: Text('list item $index, height: 50'),
              );
            },
            childCount: 20,
          ),
        )
    ]);
  }
}

class _SectionHeader extends SliverPersistentHeaderDelegate {
  final String title;
  final double extent;

  _SectionHeader({this.title, this.extent});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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