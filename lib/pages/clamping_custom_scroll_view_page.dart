import 'package:flutter/material.dart';

class ClampingCustomScrollViewPage extends StatefulWidget {
  static const rName = "ClampingCustomScrollView";

  const ClampingCustomScrollViewPage({Key? key}) : super(key: key);

  @override
  _ClampingCustomScrollViewPageState createState() =>
      _ClampingCustomScrollViewPageState();
}

class _ClampingCustomScrollViewPageState
    extends State<ClampingCustomScrollViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        reverse: true,
        center: const ValueKey(1),
        anchor: 1,
        slivers: [
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
              childCount: 10,
            ),
          ),
          SliverToBoxAdapter(
            key: const ValueKey(1),
            child: Container(
              width: double.infinity,
              height: 0,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
