import 'package:demo/clipper/index.dart';
import 'package:demo/model/index.dart';
import 'package:demo/util/assets_util.dart';
import 'package:demo/util/index.dart';
import 'package:demo/widgets/clip_tab/clip_tab_controller.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

final _pages = [
  ClipTabModel(
      color: Color(0xFFcd344f), image: Assets.rem, title: 'This is first page!'),
  ClipTabModel(
      color: Color(0xFF638de3),
      image: Assets.rem02,
      title: 'This is second page!'),
  ClipTabModel(
      color: Color(0xFFFF682D),
      image: Assets.rem,
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

  Widget tabsBuilder(
    BuildContext context,
    int activeIndex,
    int nextPageIndex,
    double progress,
    Offset startingOffset,
  ) {
    return Stack(
      children: [
        _Body(
          model: _pages[activeIndex],
        ),
        ClipOval(
          clipper: CircularClipper(
            percentage: progress,
            offset: startingOffset,
          ),
          child: _Body(
            model: _pages[nextPageIndex],
            percentage: progress,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ClipTab(
      tabsBuilder: tabsBuilder,
      clipTabController: clipTabController,
    ));
  }
}

class _Body extends StatelessWidget {
  final ClipTabModel model;
  final double percentage;

  _Body({this.model, percentage}) : this.percentage = percentage ?? 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: model.color,
      height: double.infinity,
      child: Opacity(
        opacity: percentage,
        child: Transform.translate(
          offset: Offset(0, 20 * (1 - percentage)),
          child: Image.asset(
            model.image,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
