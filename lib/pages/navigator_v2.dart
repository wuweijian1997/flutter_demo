import 'package:flutter/material.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class NavigatorV2Page extends StatefulWidget {
  static const String rName = "Navigator 2.0";
  @override
  _NavigatorV2PageState createState() => _NavigatorV2PageState();
}

class _NavigatorV2PageState extends State<NavigatorV2Page> {
  static int _counter = 15;

  final pages = [
    MaterialPage(
      key: ValueKey('/'),
      name: '/',
      child: HomeScreen(),
    ),
    MaterialPage(
      key: ValueKey('/category/5'),
      name: '/category/5',
      child: CategoryScreen(id: 5),
    ),
    MaterialPage(
      key: ValueKey('/item/15'),
      name: '/item/15',
      child: ItemScreen(id: 15),
    ),
  ];

  void addPage(MaterialPage page) {
    setState(() => pages.add(page));
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    setState(() => pages.remove(route.settings));
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => await _navigatorKey.currentState!.maybePop(),
        child: Navigator(
          key: _navigatorKey,
          onPopPage: _onPopPage,
          pages: List.of(pages),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final int id = ++_counter;
            pages.add(
              MaterialPage(
                key: ValueKey('/item/$id'),
                name: '/item/$id',
                child: ItemScreen(id: id),
              ),
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red,
      child: Center(
        child: Text(
          '第一页',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      child: Center(
        child: Text(
          '第二页',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: Center(
        child: Text(
          'Item $id',
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
