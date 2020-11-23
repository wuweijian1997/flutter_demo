import 'dart:ui';

import 'package:demo/clipper/index.dart';
import 'package:demo/util/index.dart';
import 'package:demo/widgets/clip_tab/index.dart';
import 'package:flutter/material.dart';

class CircularClippingDelegate extends ClippingTabDelegate {
  CircularClippingDelegate({@required List<Widget> tabs})
      : assert(tabs != null && tabs.length > 0),
        super(tabs: tabs);

  @override
  Widget build(BuildContext context, int activeIndex, int nextPageIndex,
      Animation animation, Offset startingOffset) {
    Log.info('CircularClippingDelegate: ${animation.value}', StackTrace.current);
    assert(activeIndex >= 0 && activeIndex < tabs.length);
    assert(nextPageIndex >= 0 && nextPageIndex < tabs.length);
    return Stack(
      children: [
        tabs[activeIndex],
        AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            Log.info('AnimatedBuilder: ${animation.value}', StackTrace.current);
            return ClipOval(
              clipper: CircularClipper(
                percentage: animation.value,
                offset: startingOffset,
              ),
              child: tabs[nextPageIndex],
            );
          },
          child: tabs[nextPageIndex],
        ),
      ],
    );
  }
}
