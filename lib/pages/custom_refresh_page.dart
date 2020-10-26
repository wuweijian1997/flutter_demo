import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CustomRefreshPage extends StatefulWidget {
  static const String rName = 'CustomRefresh';
  @override
  _CustomRefreshPageState createState() => _CustomRefreshPageState();
}

class _CustomRefreshPageState extends State<CustomRefreshPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomRefreshWidget(
              child: Center(
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
    );
  }
}
