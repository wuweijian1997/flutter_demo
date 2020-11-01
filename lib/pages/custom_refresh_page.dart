
import 'dart:math';

import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomRefreshPage extends StatefulWidget {
  static const String rName = 'CustomRefresh';

  @override
  _CustomRefreshPageState createState() => _CustomRefreshPageState();
}

class _CustomRefreshPageState extends State<CustomRefreshPage> {
  bool hasLayoutExtent = false;
  ScrollController scrollController;
  bool isScrollEnd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app bar'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if(notification is ScrollEndNotification) {
            setState(() {
              isScrollEnd = true;
            });
          }
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
                    if(constraints.maxHeight > 60 && hasLayoutExtent == false) {
                      Log.info('true', StackTrace.current);
                      SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
                        setState(() {
                          hasLayoutExtent = true;
                        });
                        Future.delayed(Duration(milliseconds: 3000), () {
                          setState(() {
                            hasLayoutExtent = false;
                          });
                        });
                      });
                    }
                    return _CustomRefresh(layoutExtent: constraints.maxHeight, isScrollEnd: isScrollEnd,);
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


class _CustomRefresh extends StatefulWidget {
  final double layoutExtent;
  final bool isScrollEnd;

  _CustomRefresh({this.layoutExtent, this.isScrollEnd, Key key}) : super(key: key);

  @override
  _CustomRefreshState createState() => _CustomRefreshState();
}

class _CustomRefreshState extends State<_CustomRefresh> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: null,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: max(60, widget.layoutExtent),
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
  }
}
