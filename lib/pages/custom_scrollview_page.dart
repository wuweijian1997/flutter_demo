import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomScrollViewPage extends StatelessWidget {
  static String rName = 'CustomScrollView';

  ///初始化不自动展开SliverAppBar
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 250 - 48.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: Builder(
              builder: (BuildContext context) {
                return CustomFlexibleSpaceBar(
                  stretchModes: StretchMode.values,
                  title: Text('Hello World'),
                  background: Image.network(
                    'https://img.zcool.cn/community/01f68d5c0d11d9a80121ab5de16b86.jpg@1280w_1l_2o_100sh.jpg',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * index % 9],
                    child: Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
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
              childCount: 300,
            ),
          )
        ],
      ),
    );
  }
}