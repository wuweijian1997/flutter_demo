import 'package:flutter/material.dart';

abstract class ClipTabDelegate {
  List<Widget> tabs;

  ClipTabDelegate({@required this.tabs});

  int get length => tabs.length;

  Widget build(
    BuildContext context,
    int activeIndex,
    int nextPageIndex,
    Animation animation,
    Offset startingOffset,
  );
}