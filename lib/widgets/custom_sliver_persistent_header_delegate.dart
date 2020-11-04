import 'package:demo/util/assets_util.dart';
import 'package:flutter/material.dart';

class CustomSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final double extent;

  CustomSliverPersistentHeaderDelegate({this.extent});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[300],
      child: Image.asset(Assets.rem),
      foregroundDecoration:
      BoxDecoration(color: Colors.grey[300].withOpacity((shrinkOffset / extent).clamp(0, 1).toDouble())),
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => extent * 0.8;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
