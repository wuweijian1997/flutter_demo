import 'package:flutter/material.dart';

abstract class ClippingTabDelegate {
  List<Widget> tabs;

  ClippingTabDelegate({this.tabs});

  int get length => tabs.length;

  Widget build(
    BuildContext context,
    int activeIndex,
    int nextPageIndex,
    double progress,
    Offset startingOffset,
  );
}
