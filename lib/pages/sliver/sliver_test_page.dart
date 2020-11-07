import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverTestPage extends StatelessWidget {
  static const String rName = 'SliverTest';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MultiSliver(
            pushPinnedChildren: true,
            children: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _SectionHeader(title: 'Test1', extent: 100),
              ),
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
              ),
            ],
          ),
         MultiSliver(
           pushPinnedChildren: true,
           children: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _SectionHeader(title: 'Test1', extent: 100),
              ),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends SliverPersistentHeaderDelegate {
  final String title;
  final double extent;

  _SectionHeader({this.title, this.extent});

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
