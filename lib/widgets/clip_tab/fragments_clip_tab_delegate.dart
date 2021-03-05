import 'package:demo/widgets/clip_tab/clip_tab_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class FragmentsClipTabDelegate extends ClipTabDelegate {
  FragmentsClipTabDelegate({
    fragmentsDrawDelegate,
    required this.screenshotController,
    required List<Widget> tabs,
  })  : assert(tabs.length > 0),
        this.fragmentsDrawDelegate = fragmentsDrawDelegate ??
            SizeFragmentsDrawDelegate(size: Size(30, 30)),
        super(tabs: tabs);
  FragmentsDrawDelegate fragmentsDrawDelegate;
  ScreenshotController screenshotController;

  @override
  Widget build(
    BuildContext context,
    int activeIndex,
    int nextPageIndex,
    Animation animation,
    Offset startingOffset,
  ) {
    assert(activeIndex >= 0 && activeIndex < tabs.length);
    assert(nextPageIndex >= 0 && nextPageIndex < tabs.length);
    return Stack(
      children: [
        tabs[nextPageIndex],
        Fragments(
          animation: animation,
          startingOffset: startingOffset,
          delegate: fragmentsDrawDelegate,
          child: tabs[activeIndex],
          screenshotController: screenshotController,
        ),
      ],
    );
  }
}
