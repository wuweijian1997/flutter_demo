import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static String rName = 'ChatPage';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController controller = ScrollController();
  List list = [];
  List newList = [];
  int old = -1;
  ValueKey<String> center = const ValueKey("center");
  bool _shouldScrollToBottom = true;
  bool _showScrollToBottomButton = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      newList.addAll([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    });
    super.initState();
  }

  void _scrollToBottom() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
    setState(() {
      _showScrollToBottomButton = false;
    });
  }

  void addNewData() {
    newList.add(list.length + newList.length + 1);
    setState(() {});
    if (_shouldScrollToBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } else {
      setState(() {
        _showScrollToBottomButton = true;
      });
    }
  }

  void loadOldData() {
    setState(() {
      list.add(old--);
      // list.insert(0, old--);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                // 当用户滚动时，检查是否接近底部
                _shouldScrollToBottom = controller.position.pixels >=
                    controller.position.maxScrollExtent - 200;
                if (_shouldScrollToBottom && _showScrollToBottomButton) {
                  setState(() {
                    _showScrollToBottomButton = false;
                  });
                }
              }
              return false;
            },
            child: CustomScrollView(
              controller: controller,
              center: center,
              slivers: [
                SliverList.builder(
                  itemBuilder: itemBuilder,
                  itemCount: list.length,
                ),
                SliverPadding(
                  padding: EdgeInsets.zero,
                  key: center,
                ),
                SliverList.builder(
                  itemBuilder: itemBuilder2,
                  itemCount: newList.length,
                ),
              ],
            ),
          ),
          if (_showScrollToBottomButton)
            Positioned(
              bottom: 20,
              left: 20,
              child: FloatingActionButton(
                onPressed: _scrollToBottom,
                child: const Icon(Icons.arrow_downward),
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: loadOldData,
            tooltip: 'old data',
            child: const Icon(Icons.arrow_upward),
          ),
          FloatingActionButton(
            onPressed: addNewData,
            tooltip: 'new data',
            child: const Icon(Icons.arrow_downward),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Text(
        "${list[index]}",
        style: const TextStyle(fontSize: 36),
      ),
    );
  }

  Widget itemBuilder2(BuildContext context, int index) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Text(
        "${newList[index]}",
        style: const TextStyle(fontSize: 36),
      ),
    );
  }
}