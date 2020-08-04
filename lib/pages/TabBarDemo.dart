import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabBarDemo extends StatefulWidget {
  static const rName = 'TabBarDemo';

  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TabViewDemo();
  }
}

class TabViewDemo extends StatefulWidget {

  @override
  _TabViewDemoState createState() => _TabViewDemoState();
}

class _TabViewDemoState extends State<TabViewDemo> with TickerProviderStateMixin{
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  final List<Widget> list = [
    TabBarPageDemo('111'),
    TabBarPageDemo('222'),
    TabBarPageDemo('333'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBarDemo'),
        bottom: TabBarCustom(
          controller: controller,
          isScrollable: false,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            gradient: LinearGradient(
              colors: [
                Color(0xff5B8CFF),
                Color(0xff993DF6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          tabs: <Widget>[
            Tab(text: '111',),
            Tab(text: '222',),
            Tab(text: '333',),
          ],
        ),
      ),
      body: TabBarViewDemo(
        controller: controller,
        children: list,
      ));
  }
}

class TabBarPageDemo extends StatefulWidget {
  final String title;

  TabBarPageDemo(this.title);

  @override
  _TabBarPageDemoState createState() => _TabBarPageDemoState();
}

class _TabBarPageDemoState extends State<TabBarPageDemo> with AutomaticKeepAliveClientMixin<TabBarPageDemo>{

  Map<String, Color> map = {
    '111': Colors.red,
    '222': Colors.green,
    '333': Colors.blue,
  };

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build ${widget.title}');
    return Container(
      color: map[widget.title],
      child: Center(
        child: Text(widget.title),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('initState ${widget.title}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies ${widget.title}');
  }


  @override
  void dispose() {
    super.dispose();
    print('dispose ${widget.title}');
  }

  @override
  bool get wantKeepAlive => true;
}
