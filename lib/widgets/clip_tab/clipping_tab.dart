import 'package:demo/widgets/clip_tab/clipping_tab_controller.dart';
import 'package:demo/widgets/clip_tab/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class ClippingTab extends StatefulWidget {
  final ClippingTabController clipTabController;
  final ClippingTabDelegate clipTabDelegate;

  ClippingTab({
    Key key,
    this.clipTabController,
    this.clipTabDelegate,
  }) : super(key: key);

  @override
  _ClippingTabState createState() => _ClippingTabState();
}

class _ClippingTabState extends State<ClippingTab> with SingleTickerProviderStateMixin {
  ClippingTabDelegate get clipTabDelegate => widget.clipTabDelegate;

  ClippingTabController _clipTabController;

  ClippingTabController get clipTabController => widget.clipTabController;

  @override
  void initState() {
    super.initState();
    _clipTabController = clipTabController ??
        ClippingTabController(length: clipTabDelegate.length, vsync: this);
    _clipTabController.init();
    _clipTabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ClippingTabDrag(
      clipTabController: _clipTabController,
      child: clipTabDelegate.build(
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
