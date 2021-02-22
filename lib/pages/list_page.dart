import 'dart:math';

import 'package:demo/model/index.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  static const String rName = "ListPage";

  ListPage(this.list);

  final List<ListPageModel> list;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  final _navigatorKey = GlobalKey<NavigatorState>();
  final pages = <MaterialPage>[];


  @override
  void initState() {
    super.initState();
    pages.add(MaterialPage(
      key: Key('/'),
      name: '/',
      child: _List(list: widget.list, onPush: addPage,),
    ));
  }

  void addPage(ListPageModel model) {
    setState(() => pages.add(MaterialPage(
      key: Key(model.title),
      name: model.title,
      child: Scaffold(
        body: model.page,
      ),
    )));
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    setState(() => pages.remove(route.settings));
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
      child: Navigator(
        key: _navigatorKey,
        onPopPage: _onPopPage,
        pages: List.of(pages),
      ),
    );
  }
}

class _List extends StatelessWidget {
  final List<ListPageModel> list;
  final ValueChanged<ListPageModel> onPush;


  _List({this.list, this.onPush});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        itemCount: list?.length ?? 0,
        itemBuilder: (_, index) {
          return _ListItem(model: list[index], onPress: onPush,);
        },
      ),
    );
  }
}


class _ListItem extends StatelessWidget {
  final ListPageModel model;
  final Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  final Color shadowColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  final ValueChanged<ListPageModel> onPress;

  _ListItem({this.model, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress.call(model),
      child: Card(
        shadowColor: shadowColor,
        elevation: 10,
        margin: EdgeInsets.only(top: 10),
        color: color,
        child: Container(
          height: 100,
          alignment: Alignment.center,
          child: Text(model.title, style: TextStyle(fontSize: 24),),
        ),
      ),
    );
  }
}
