import 'package:demo/model/index.dart';
import 'package:demo/util/assets_util.dart';
import 'package:demo/util/index.dart';
import 'package:demo/widgets/clip_tab/circular_clip_tab_delegate.dart';
import 'package:demo/widgets/clip_tab/clip_tab_controller.dart';
import 'package:demo/widgets/clip_tab/index.dart';
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

class SizeClipTabPage extends StatefulWidget {
  static const String rName = 'SizeClipperTab';

  @override
  _SizeClipTabPageState createState() => _SizeClipTabPageState();
}

class _SizeClipTabPageState extends State<SizeClipTabPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ClipTab(
          clipTabDelegate: SizeClipTabDelegate(
            tabs: [
              for (ClipTabModel model in _pages)
                ClipTabItem(
                  model: model,
                ),
            ],
          ),
        ),
      ],
    ));
  }
}
