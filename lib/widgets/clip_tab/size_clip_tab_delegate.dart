import 'package:demo/widgets/clip_tab/index.dart';
import 'package:flutter/material.dart';

class SizeClipTabDelegate extends ClipTabDelegate {
  SizeClipTabDelegate({List<Widget> tabs}) : super(tabs: tabs);

  @override
  Widget build(
    BuildContext context,
    int activeIndex,
    int nextPageIndex,
    Animation animation,
    Offset startingOffset,
  ) {
    return Stack(
      children: [
        tabs[activeIndex],
        SizeTransition(
          sizeFactor: animation,
          child: tabs[nextPageIndex],
        )
      ],
    );
  }
}
