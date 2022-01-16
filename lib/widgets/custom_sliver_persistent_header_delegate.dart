import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class CustomSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final double extent;

  CustomSliverPersistentHeaderDelegate({required this.extent});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    Log.info('shrinkOffset: $shrinkOffset', StackTrace.current);
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.grey[300],
            child: Image.asset(Assets.rem),
            foregroundDecoration:
            BoxDecoration(color: Colors.grey[300]!.withOpacity((shrinkOffset / extent).clamp(0, 1).toDouble())),
          ),
        ),
      ],
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
