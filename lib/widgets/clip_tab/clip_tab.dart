import 'package:demo/widgets/clip_tab/clip_tab_controller.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

typedef TabsBuilder = Widget Function(
    BuildContext context,
    int activeIndex,
    int nextPageIndex,
    double progress,
    Offset startingOffset,
    );

class ClipTab extends StatefulWidget {
  final int tabs;
  final TabsBuilder tabsBuilder;
  final ClipTabController clipTabController;

  ClipTab({
    Key key,
    this.tabs,
    @required this.tabsBuilder,
    this.clipTabController,
  }) : super(key: key);

  @override
  _ClipTabState createState() => _ClipTabState();
}

class _ClipTabState extends State<ClipTab> with SingleTickerProviderStateMixin {

  TabsBuilder get tabsBuilder => widget.tabsBuilder;

  int get tabs => widget.tabs;

  ClipTabController _clipTabController;
  ClipTabController get clipTabController => widget.clipTabController;

  @override
  void initState() {
    super.initState();
    _clipTabController = clipTabController ?? ClipTabController(length: tabs, vsync: this);
    _clipTabController.init();
    _clipTabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ClipperTabDrag(
      clipTabController: _clipTabController,
      child: tabsBuilder.call(
        context,
        _clipTabController.index,
        _clipTabController.nextPageIndex,
        _clipTabController.value,
        _clipTabController.dragStartOffset,
      ),
    );
  }

  @override
  void dispose() {
    _clipTabController.dispose();
    super.dispose();
  }
}
