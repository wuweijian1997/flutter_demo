
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class RefreshPage extends StatefulWidget {
  static const String rName = 'CustomRefresh';

  @override
  _RefreshPageState createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {
  late ValueNotifier<bool> _focusNotifier;

  @override
  void initState() {
    super.initState();
    _focusNotifier = ValueNotifier<bool>(false);
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('app bar'),
      ),
      body: ScrollNotificationListener(
        onFocus: (bool focus) {
          _focusNotifier.value = focus;
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverRefreshBuilder(
              refreshTriggerPullDistance: 100,
              refreshIndicatorExtent: 60,
              focusNotifier: _focusNotifier,
              onRefresh: refresh,
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
            )
          ],
        ),
      ),
    );
  }
}
