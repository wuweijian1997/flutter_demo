
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class WeChatHomeDropDown extends StatefulWidget {
  static const String rName = 'WeChatHomeDropDown';

  @override
  _WeChatHomeDropDownState createState() => _WeChatHomeDropDownState();
}

class _WeChatHomeDropDownState extends State<WeChatHomeDropDown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          return CustomScrollView(
            slivers: [
              SliverWeChatHomeDropDown(layoutExtent: constraints.maxHeight, bottomExtent: 80.0,),
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
