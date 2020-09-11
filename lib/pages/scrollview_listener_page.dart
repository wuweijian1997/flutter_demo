import 'package:flutter/material.dart';

class ScrollViewListenerDemoPage extends StatefulWidget {
  static const rName = 'ScrollViewListener';

  const ScrollViewListenerDemoPage({
    Key key,
  }) : super(key: key);

  @override
  _ScrollViewListenerDemoPageState createState() => _ScrollViewListenerDemoPageState();
}

///两周方式可以监听
///controller:
/// 1.可以设置默认值offset
/// 2.监听滚动,也可以监听滚动的位置
///NotificationListener
/// 1.开始滚动和结束滚动
class _ScrollViewListenerDemoPageState extends State<ScrollViewListenerDemoPage> {
  ScrollController controller = ScrollController();
  bool _isShowFloatingButton = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
//      print('kafka: 监听滚动 - ${controller.offset}');
      if (controller.offset > 1000 && _isShowFloatingButton == false) {
        setState(() {
          _isShowFloatingButton = true;
        });
      }
      if (controller.offset < 1000 && _isShowFloatingButton == true) {
        setState(() {
          _isShowFloatingButton = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (ScrollNotification scrollNotification) {
          print('kafka: 监听滚动. NotificationListener');
          if(scrollNotification is ScrollStartNotification) {
            print('kafka: 监听滚动. 开始滚动');
          } else if(scrollNotification is ScrollEndNotification) {
            print('kafka: 监听滚动. 结束滚动');
          } else if(scrollNotification is ScrollUpdateNotification) {
            print('kafka: 监听滚动. 正在滚动. '
                '总滚动距离: ${scrollNotification.metrics.maxScrollExtent}'
                '当前位置: ${scrollNotification.metrics.pixels}');
          }
          return true;
        },
        child: ListView.builder(
          controller: controller,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.people),
              title: Text('联系人:$index'),
            );
          },
          itemCount: 50,
        ),
      ),
      floatingActionButton: Offstage(
        offstage: !_isShowFloatingButton,
        child: FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: () {
//          controller.jumpTo(0);
            controller.animateTo(
                0, duration: Duration(seconds: 1), curve: Curves.easeIn);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
