import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class ClipTab extends StatelessWidget {
  static const rName = "ClipTab";
  @override
  Widget build(BuildContext context) {
    return ListPage([
      ListPageModel(
        title: FragmentsClipTabPage.rName,
        page: FragmentsClipTabPage(),
      ),
      ListPageModel(
        title: CircularClipperTabPage.rName,
        page: CircularClipperTabPage(),
      ),
      ListPageModel(
        title: SizeClipTabPage.rName,
        page: SizeClipTabPage(),
      ),
    ]);
  }
}
