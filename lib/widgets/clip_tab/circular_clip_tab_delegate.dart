import 'dart:ui';

import 'package:demo/effect/index.dart';
import 'package:demo/widgets/clip_tab/index.dart';
import 'package:flutter/material.dart';

class CircularClipDelegate extends ClipTabDelegate {
  CircularClipDelegate({required List<Widget> tabs})
      : assert(tabs.length > 0),
        super(tabs: tabs);

  @override
  Widget build(BuildContext context, int activeIndex, int nextPageIndex,
      Animation animation, Offset startingOffset) {
    assert(activeIndex >= 0 && activeIndex < tabs.length);
    assert(nextPageIndex >= 0 && nextPageIndex < tabs.length);
    return Stack(
      children: [
        tabs[activeIndex],
        ClipOval(
          clipper: CircularClipper(
            percentage: animation.value,
            offset: startingOffset,
          ),
          child: tabs[nextPageIndex],
        )
      ],
    );
  }
}
