import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class SliverGeometryTestPage extends StatefulWidget {
  static const String rName = 'SliverGeometry';

  @override
  _SliverGeometryTestPageState createState() => _SliverGeometryTestPageState();
}

class _SliverGeometryTestPageState extends State<SliverGeometryTestPage> {
  double value = 0;

  _onClick() {
    setState(() {
      value = 150;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverGeometryTest(
            value: value,
            child: Container(
              color: Colors.red,
              height: 300,
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
              childCount: 50,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClick,
      ),
    );
  }
}
