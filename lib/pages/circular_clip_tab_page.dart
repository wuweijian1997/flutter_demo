import 'package:demo/const/index.dart';
import 'package:demo/model/index.dart';
import 'package:demo/widgets/clip_tab/circular_clip_tab_delegate.dart';
import 'package:demo/widgets/clip_tab/clip_tab_controller.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

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
              for (ClipTabModel model in Const.pages)
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
