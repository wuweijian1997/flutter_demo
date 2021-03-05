import 'package:demo/model/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class SliverConstraintsOverlapPage extends StatefulWidget {
  static const String rName = "SliverConstraintsOverlap";

  @override
  _SliverConstraintsOverlapPageState createState() =>
      _SliverConstraintsOverlapPageState();
}

class _SliverConstraintsOverlapPageState
    extends State<SliverConstraintsOverlapPage> {
  ValueNotifier<SliverModel> constraintsNotifier =
      ValueNotifier(SliverModel(overlap: 0, scrollOffset: 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /*    SliverAppBar(
            pinned: true,
            title: Text(SliverConstraintsOverlapPage.rName),
          ),*/
          SliverConstraintsOverlap(
            constraintsNotifier: constraintsNotifier,
            child: StatefulBuilder(
              builder: (_, _setState) {
                constraintsNotifier.addListener(() {
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    _setState.call(() {});
                  });
                });
                return Container(
                  height: 300,
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text(
                    '${constraintsNotifier.value}',
                    style: TextStyle(fontSize: 24),
                  ),
                );
              },
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
                  child: Text('list item $index, height: 50'),
                );
              },
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
