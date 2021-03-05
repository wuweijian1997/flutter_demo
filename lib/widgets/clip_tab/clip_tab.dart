import 'package:demo/widgets/clip_tab/clip_tab_controller.dart';
import 'package:demo/widgets/clip_tab/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class ClipTab extends StatefulWidget {
  final ClipTabController? clipTabController;
  final ClipTabDelegate clipTabDelegate;

  ClipTab({
    Key? key,
    this.clipTabController,
    required this.clipTabDelegate,
  }) : super(key: key);

  @override
  _ClipTabState createState() => _ClipTabState();
}

class _ClipTabState extends State<ClipTab>
    with SingleTickerProviderStateMixin {
  ClipTabDelegate get clipTabDelegate => widget.clipTabDelegate;

  late ClipTabController _clipTabController;

  ClipTabController? get clipTabController => widget.clipTabController;

  @override
  void initState() {
    super.initState();
    _clipTabController = clipTabController ??
        ClipTabController(length: clipTabDelegate.length, vsync: this);
    _clipTabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipTabDrag(
      clipTabController: _clipTabController,
      child: clipTabDelegate.build(
        context,
        _clipTabController.index,
        _clipTabController.nextPageIndex,
        _clipTabController.animation,
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
