import 'package:demo/const/index.dart';
import 'package:demo/model/index.dart';
import 'package:demo/widgets/clip_tab/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import  'package:flutter_fragments/flutter_fragments.dart';

class FragmentsClipTabPage extends StatefulWidget {
  static const String rName = 'FragmentsClipperTab';

  @override
  _FragmentsClipTabPageState createState() =>
      _FragmentsClipTabPageState();
}

class _FragmentsClipTabPageState extends State<FragmentsClipTabPage>
    with SingleTickerProviderStateMixin {
  late ClipTabController clipTabController;
  ScreenshotController screenShotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    clipTabController = ClipTabController(vsync: this, length: 3);
    clipTabController.addStatusListener((status) {
      if (status == SlideStatus.dragStart) {
        screenShotController.generateImage(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipTab(
        clipTabController: clipTabController,
        clipTabDelegate: FragmentsClipTabDelegate(
          screenshotController: screenShotController,
          tabs: [
            for (ClipTabModel model in Const.pages)
              ClipTabItem(
                model: model,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    screenShotController.dispose();
    super.dispose();
  }
}
