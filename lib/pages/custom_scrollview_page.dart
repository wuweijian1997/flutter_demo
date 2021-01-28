import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/index.dart';

class CustomScrollViewPage extends StatelessWidget {
  static String rName = 'CustomScrollView';

  ///初始化不自动展开SliverAppBar
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 250 - 48.0);
  final CountdownTimerController countdownTimerController =
      CountdownTimerController(
          endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60);

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
          SliverToBoxAdapter(
            child: _CountdownDemo(),
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

class _CountdownDemo extends StatefulWidget {
  @override
  __CountdownDemoState createState() => __CountdownDemoState();
}

class __CountdownDemoState extends State<_CountdownDemo> {

  final CountdownTimerController countdownTimerController =
  CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60);

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      controller: countdownTimerController,
    );
  }
  @override
  void dispose() {
    super.dispose();
    Log.info("dispose", StackTrace.current);
  }

  @override
  void initState() {
    super.initState();
    Log.info("initState", StackTrace.current);
  }

  @override
  void didUpdateWidget(covariant _CountdownDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    Log.info("didUpdateWidget", StackTrace.current);
  }
}
