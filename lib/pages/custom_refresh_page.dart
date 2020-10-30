
import 'dart:math';

import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CustomRefreshPage extends StatefulWidget {
  static const String rName = 'CustomRefresh';

  @override
  _CustomRefreshPageState createState() => _CustomRefreshPageState();
}

class _CustomRefreshPageState extends State<CustomRefreshPage> {
  bool hasLayoutExtent = false;
  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app bar'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          return true;
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            CustomRefreshWidget(
                refreshLayoutExtent: 60.0,
                hasLayoutExtent: hasLayoutExtent,
                child: LayoutBuilder(
                  builder: (_, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        Positioned(
                          top: null,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: max(60, constraints.maxHeight),
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: CustomLoading(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建列表项
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 10)],
                    child: Text('list item $index'),
                  );
                },
                childCount: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
