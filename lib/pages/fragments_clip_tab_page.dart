import 'package:demo/model/index.dart';
import 'package:demo/util/assets_util.dart';
import 'package:demo/util/index.dart';
import 'package:demo/widgets/clip_tab/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

final _pages = [
  ClipTabModel(
      color: Color(0xFFcd344f),
      image: Assets.eat_cape_town_sm,
      title: 'This is red page!'),
  ClipTabModel(
      color: Color(0xFF638de3),
      image: Assets.rem02,
      title: 'This is blue page!'),
  ClipTabModel(
      color: Color(0xFFFF682D),
      image: Assets.rem,
      title: 'This is orange page!'),
];

class FragmentsClipTabPage extends StatefulWidget {
  static const String rName = 'FragmentsClipperTab';

  @override
  _FragmentsClipTabPageState createState() =>
      _FragmentsClipTabPageState();
}

class _FragmentsClipTabPageState extends State<FragmentsClipTabPage>
    with SingleTickerProviderStateMixin {
  ClipTabController clipTabController;
  FragmentsController fragmentsController;

  @override
  void initState() {
    super.initState();
    clipTabController = ClipTabController(vsync: this, length: 3);
    fragmentsController = FragmentsController(
      animationController: clipTabController.animationController,
    );
    clipTabController.addStatusListener((status) {
      if (status == SlideStatus.dragStart) {
        fragmentsController.generateImage(() {
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipTab(
        clipTabController: clipTabController,
        clipTabDelegate: FragmentsClipTabDelegate(
          tabs: [
            for (ClipTabModel model in _pages)
              _Item(
                model: model,
              ),
          ],
          fragmentsController: fragmentsController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    clipTabController.dispose();
    super.dispose();
  }
}

class _Item extends StatelessWidget {
  final ClipTabModel model;
  final double percentage;

  _Item({this.model, this.percentage = 1});

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
