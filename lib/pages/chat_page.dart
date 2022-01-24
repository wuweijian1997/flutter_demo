import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static String rName = 'ChatPage';

  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController controller = ScrollController();
  UniqueKey centerKey = UniqueKey();
  List<int> oldList = [0, 1];
  List<int> newList = [];

  @override
  void initState() {
    // controller.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.ease);
    super.initState();
  }

  scrollEnd() {
    ScrollPosition position = controller.position;
    Log.info(
        'position: $position, extentAfter: ${position.extentAfter} extentBefore: ${position.extentBefore} extentInside: ${position.extentInside} ');
    controller.animateTo(position.minScrollExtent, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (ScrollUpdateNotification notification) {
          // Log.info('notification: $notification', StackTrace.current);
          return false;
        },
        child: CustomScrollView(
          reverse: true,
          center: centerKey,
          controller: controller,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return buildChatItem(newList[index]);
                },
                childCount: newList.length,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.zero,
              key: centerKey,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return buildChatItem(oldList[index]);
                },
                childCount: oldList.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            int value = newList.length + oldList.length;
            newList.add(value);
            scrollEnd();
          });
        },
      ),

    );
  }

  buildChatItem(int value) {
    return Container(
      height: 100,
      color: Colors.red,
      margin: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: Text('$value'),
    );
  }
}
