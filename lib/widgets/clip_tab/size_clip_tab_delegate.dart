import 'package:demo/widgets/clip_tab/index.dart';
import 'package:flutter/material.dart';

class SizeClipTabDelegate extends ClipTabDelegate {
  SizeClipTabDelegate({required List<Widget> tabs}) : super(tabs: tabs);

  @override
  Widget build(
    BuildContext context,
    int activeIndex,
    int nextPageIndex,
    Animation<double> animation,
    Offset startingOffset,
  ) {
    return Stack(
      children: [
        tabs[activeIndex],
        SlideTransition(
          position: animation.drive(Tween<Offset>(
            begin: Offset(1, 1),
            end: Offset.zero,
          )),
          child: SizeTransition(
            sizeFactor: animation,
            child: tabs[nextPageIndex],
          ),
        )
      ],
    );
  }
}
