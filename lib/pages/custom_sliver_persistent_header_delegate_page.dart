import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CustomSliverPersistentHeaderDelegatePage extends StatefulWidget {
  static const String rName = 'SliverPersistentHeaderDelegate';

  @override
  _CustomSliverPersistentHeaderDelegatePageState createState() =>
      _CustomSliverPersistentHeaderDelegatePageState();
}

class _CustomSliverPersistentHeaderDelegatePageState
    extends State<CustomSliverPersistentHeaderDelegatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: CustomSliverPersistentHeaderDelegate(extent: constraints.maxHeight - 80),
              ),
              ///appBar: height = 56,
              SliverAppBar(
                backgroundColor: Colors.grey[300],
                leading: Center(
                    child: Text(
                      '微信',
                      style: TextStyle(fontSize: 20),
                    )),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      size: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 24,
                    ),
                  )
                ],
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
          );
        },
      ),
    );
  }
}
