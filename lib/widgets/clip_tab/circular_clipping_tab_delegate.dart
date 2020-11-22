import 'dart:ui';

import 'package:demo/clipper/index.dart';
import 'package:demo/widgets/clip_tab/index.dart';
import 'package:flutter/material.dart';

class CircularClippingDelegate extends ClippingTabDelegate {
  CircularClippingDelegate({@required List<Widget> tabs})
      : assert(tabs != null && tabs.length > 0),
        super(tabs: tabs);

  @override
  Widget build(BuildContext context, int activeIndex, int nextPageIndex,
      double progress, Offset startingOffset) {
    assert(activeIndex >= 0 && activeIndex < tabs.length);
    assert(nextPageIndex >= 0 && nextPageIndex < tabs.length);
    return Stack(
      children: [
        tabs[activeIndex],
        ClipOval(
          clipper: CircularClipper(
            percentage: progress,
            offset: startingOffset,
          ),
          child: tabs[nextPageIndex],
        ),
      ],
    );
  }
}
