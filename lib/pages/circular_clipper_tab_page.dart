import 'package:demo/clipper/index.dart';
import 'package:demo/model/index.dart';
import 'package:demo/util/assets_util.dart';
import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

final pages = [
  ClipTabModel(
      color: Color(0xFFcd344f), image: Assets.rem, title: 'This is red page!'),
  ClipTabModel(
      color: Color(0xFF638de3),
      image: Assets.rem02,
      title: 'This is blue page!'),
  ClipTabModel(
      color: Color(0xFFFF682D),
      image: Assets.rem,
      title: 'This is orange page!'),
];

class CircularClipperTabPage extends StatefulWidget {
  static const String rName = 'CircularClipperTab';

  @override
  _CircularClipperTabPageState createState() => _CircularClipperTabPageState();
}

class _CircularClipperTabPageState extends State<CircularClipperTabPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ClipTab(
            tabs: 3,
            tabBuilder: (
              BuildContext context,
              int index,
              double progress, {
              bool isNextPage = false,
              Offset startingOffset = Offset.zero,
            }) {
              if (isNextPage) {
                return ClipOval(
                  clipper: CircularClipper(
                      percentage: progress, offset: startingOffset),
                  child: _Body(
                    model: pages[index],
                    percentage: progress,
                  ),
                );
              }
              return _Body(
                model: pages[index],
                percentage: progress,
              );
            }));
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
