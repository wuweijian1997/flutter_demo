import 'package:demo/model/index.dart';
import 'package:demo/util/assets_util.dart';
import 'package:demo/util/index.dart';
import 'package:demo/widgets/clip_tab/circular_clip_tab_delegate.dart';
import 'package:demo/widgets/clip_tab/clip_tab_controller.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

final _pages = [
  ClipTabModel(
      color: Color(0xFFcd344f),
      image: Assets.rem,
      title: 'This is first page!'),
  ClipTabModel(
      color: Color(0xFF638de3),
      image: Assets.rem02,
      title: 'This is second page!'),
  ClipTabModel(
      color: Color(0xFFFF682D),
      image: Assets.eat_cape_town_sm,
      title: 'This is third page!'),
];

class CircularClipperTabPage extends StatefulWidget {
  static const String rName = 'CircularClipperTab';

  @override
  _CircularClipperTabPageState createState() => _CircularClipperTabPageState();
}

class _CircularClipperTabPageState extends State<CircularClipperTabPage>
    with SingleTickerProviderStateMixin {
  ClipTabController clipTabController;

  @override
  void initState() {
    super.initState();
    clipTabController = ClipTabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ClipTab(
          clipTabController: clipTabController,
          clipTabDelegate: CircularClipDelegate(
            tabs: [
              for (ClipTabModel model in _pages)
                ClipTabItem(
                  model: model,
                ),
            ],
          ),
        ),
        Positioned(
          right: 30,
          bottom: 50,
          child: Column(
            children: [
              Button(
                child: Icon(Icons.navigate_next),
                onClick: () {
                  clipTabController.toNextPage();
                },
              ),
              Button(
                child: Icon(Icons.navigate_before),
                onClick: () {
                  clipTabController.toPreviousPage();
                },
              ),
            ],
          ),
        )
      ],
    ));
  }
}
