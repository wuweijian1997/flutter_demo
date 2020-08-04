import 'package:demo/widgets/TabBarView.dart';
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

class _TabBarDemoState2 extends State<TabBarDemo>{
  final List<Widget> list = [
    TabBarPageDemo('111'),
    TabBarPageDemo('222'),
    TabBarPageDemo('333'),
    TabBarPageDemo('444'),
  ];

  int _tabIndex = 0;

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView.builder(//要点1
          physics: AlwaysScrollableScrollPhysics(),//禁止页面左右滑动切换
          controller: _pageController,
          onPageChanged: _pageChanged,//回调函数
          itemCount: list.length,
          itemBuilder: (context,index)=>list[index]
      ),
      bottomNavigationBar:BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(title:Text('主页'),icon: Icon(Icons.home)),
          BottomNavigationBarItem(title:Text('商城'),icon: Icon(Icons.shopping_basket)),
          BottomNavigationBarItem(title:Text('测试'),icon: Icon(Icons.pageview)),
          BottomNavigationBarItem(title:Text('我的'),icon: Icon(Icons.account_box)),
        ],
        onTap: (index){
          print('onTap');
          _pageController.jumpToPage(index);
//          _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        },
        type:BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
      ),


    )    ;
  }

  void _pageChanged(int value) {
    setState(() {
      _tabIndex = value;
    });
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
        bottom: TabBar(
          controller: controller,
          isScrollable: false,
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
