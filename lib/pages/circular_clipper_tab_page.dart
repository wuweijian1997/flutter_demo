import 'package:demo/model/index.dart';
import 'package:demo/util/assets_util.dart';
import 'package:demo/util/index.dart';
import 'package:demo/widgets/clip_tab/circular_clipping_tab_delegate.dart';
import 'package:demo/widgets/clip_tab/clipping_tab_controller.dart';
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
  ClippingTabController clipTabController;

  @override
  void initState() {
    super.initState();
    clipTabController = ClippingTabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ClippingTab(
          clipTabController: clipTabController,
          clipTabDelegate: CircularClippingDelegate(
            tabs: [
              for (ClipTabModel model in _pages)
                _Item(
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

class _Item extends StatelessWidget {
  final ClipTabModel model;
  final double percentage;

  _Item({this.model, percentage, Key key})
      : this.percentage = percentage ?? 1,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: model.color,
      height: double.infinity,
      child: Opacity(
        opacity: percentage,
        child: Container(
          alignment: Alignment.center,
          transform: Matrix4.translationValues(0, 20 * (1 - percentage), 0.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                model.image,
              )
            )
          ),
          child: Text(model.title),
        ),
      ),
    );
  }
}
