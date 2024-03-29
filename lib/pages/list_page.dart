import 'dart:math';

import 'package:demo/model/index.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  static const String rName = "ListPage";

  const ListPage(this.list, {Key? key}) : super(key: key);

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
      key: const ValueKey('/'),
      name: '/',
      child: _List(list: widget.list, onPush: addPage,),
    ));
  }

  void addPage(ListPageModel model) {
    setState(() => pages.add(MaterialPage(
      key: ValueKey(model.title),
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
      onWillPop: () async => !await _navigatorKey.currentState!.maybePop(),
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


  const _List({required this.list, required this.onPush});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        itemCount: list.length,
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

  _ListItem({required this.model, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress.call(model),
      child: Card(
        shadowColor: shadowColor,
        elevation: 10,
        margin: const EdgeInsets.only(top: 10),
        color: color,
        child: Container(
          height: 100,
          alignment: Alignment.center,
          child: Text(model.title, style: const TextStyle(fontSize: 24), maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
