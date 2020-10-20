import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CustomTabViewPage extends StatefulWidget {
  static const String rName= "CustomTabView";
  @override
  _CustomTabViewPageState createState() => _CustomTabViewPageState();
}

class _CustomTabViewPageState extends State<CustomTabViewPage> with TickerProviderStateMixin{
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      if(controller.indexIsChanging) {
        Log.info('index: ${controller.index}, previousIndex: ${controller.previousIndex}', StackTrace.current);
      }
      Log.info('index: ${controller.index}, previousIndex: ${controller.previousIndex}', StackTrace.current);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            CustomTabBar(
              controller: controller,
              tabs: [
                Tab(text: 'RED'),
                Tab(text: 'YELLOW'),
                Tab(text: 'BLUE'),
              ],
            ),
            Expanded(
              child: CustomTabBarView(
                controller: controller,
                children: [
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.yellow,
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
