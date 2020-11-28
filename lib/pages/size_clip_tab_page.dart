import 'package:demo/const/index.dart';
import 'package:demo/model/index.dart';
import 'package:demo/widgets/clip_tab/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

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
              for (ClipTabModel model in Const.pages)
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
