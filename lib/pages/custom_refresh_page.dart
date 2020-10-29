import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CustomRefreshPage extends StatefulWidget {
  static const String rName = 'CustomRefresh';
  @override
  _CustomRefreshPageState createState() => _CustomRefreshPageState();
}

class _CustomRefreshPageState extends State<CustomRefreshPage> {
  bool hasLayoutExtent = true;
  ScrollController scrollController;


  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
    });
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        hasLayoutExtent = false;
      });
    });
  }

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
                layoutExtent: 100.0,
                hasLayoutExtent: hasLayoutExtent,
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: CustomLoading(),
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
