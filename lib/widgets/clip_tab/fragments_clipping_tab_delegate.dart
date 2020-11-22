import 'package:demo/util/index.dart';
import 'package:demo/widgets/clip_tab/clipping_tab_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class FragmentsClippingTabDelegate extends ClippingTabDelegate {
  FragmentsClippingTabDelegate({
    delegate,
    this.fragmentsController,
    @required List<Widget> tabs,
  })  : assert(tabs != null && tabs.length > 0),
        this.delegate =
            delegate ?? DefaultFragmentsDraw(rowLength: 25, columnLength: 25),
        super(tabs: tabs);
  FragmentsDrawDelegate delegate;
  FragmentsController fragmentsController;

  @override
  Widget build(
    BuildContext context,
    int activeIndex,
    int nextPageIndex,
    double progress,
    Offset startingOffset,
  ) {
    assert(activeIndex >= 0 && activeIndex < tabs.length);
    assert(nextPageIndex >= 0 && nextPageIndex < tabs.length);
    return Stack(
      children: [
        tabs[nextPageIndex],
        Fragments(
          fragmentsController: fragmentsController,
          startingOffset: startingOffset,
          delegate: delegate,
          child: tabs[activeIndex],
        ),
      ],
    );
  }
}
