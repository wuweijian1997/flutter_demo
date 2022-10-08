import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class ClipTab extends StatelessWidget {
  static const rName = "ClipTab";

  const ClipTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListPage([
      ListPageModel(
        title: CircularClipperTabPage.rName,
        page: const CircularClipperTabPage(),
      ),
      ListPageModel(
        title: SizeClipTabPage.rName,
        page: const SizeClipTabPage(),
      ),
    ]);
  }
}
