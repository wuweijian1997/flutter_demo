import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class RenderObjectPage extends StatefulWidget {
  static const String rName = "RenderObject";

  @override
  _RenderObjectPageState createState() => _RenderObjectPageState();
}

class _RenderObjectPageState extends State<RenderObjectPage> {
  static final String page = WidgetDetailPage.rName;
  final List<PageRouteModel> list = [
    PageRouteModel(
      page: page,
      title: 'Padding',
      arguments: Container(
        color: Colors.blue,
        child: CustomPadding(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(0),
          child: Container(
            color: Colors.red,
          ),
        ),
      ),
    ),
  ];

  List<Page> pages = [];


  @override
  void initState() {
    super.initState();
    pages = [
      MaterialPage(
        key: Key('/'),
        name: '/',
        child: ListCard(
            list: list,
            onPress: (PageRouteModel model) {
              setState(() {
                pages.add(
                  MaterialPage(
                    key: Key('/item/${model.page}'),
                    name: '/item/${model.page}',
                    child: WidgetDetailPage(),
                    arguments: model.arguments,
                  ),
                );
              });
            }
        ),
      ),
    ];
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    setState(() => pages.remove(route.settings));
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
        child: Navigator(
          key: _navigatorKey,
          onPopPage: _onPopPage,
          pages: List.of(pages),
        ),
      ),
    );
  }
}
