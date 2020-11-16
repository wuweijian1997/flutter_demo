import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class PictureFragmentsPage extends StatefulWidget {
  static const String rName = 'Fragments';

  @override
  _PictureFragmentsPageState createState() => _PictureFragmentsPageState();
}

class _PictureFragmentsPageState extends State<PictureFragmentsPage> {
  final List<PageRouteModel> list = [
    PageRouteModel(
      page: PictureFragmentsPage.rName,
      title: 'Default',
      arguments: _PictureDetail(
        delegate: DefaultFragmentsDraw(disableTransition: true),
      ),
    ),
    PageRouteModel(
      page: PictureFragmentsPage.rName,
      title: 'Transition',
      arguments: _PictureDetail(
        delegate: DefaultFragmentsDraw(rowLength: 20, columnLength: 20),
      ),
    ),
    PageRouteModel(
      page: PictureFragmentsPage.rName,
      title: 'Custom Number',
      arguments: _PictureDetail(
        delegate: DefaultFragmentsDraw(rowLength: 25, columnLength: 25),
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
            }),
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

class _PictureDetail extends StatefulWidget {
  final FragmentsDrawDelegate delegate;

  _PictureDetail({@required this.delegate});

  @override
  __PictureDetailState createState() => __PictureDetailState();
}

class __PictureDetailState extends State<_PictureDetail> {
  FragmentsController controller = FragmentsController();
  Offset startingPoint = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapUp: (TapUpDetails detail) {
            setState(() {
              startingPoint = detail.localPosition;
            });
            controller.start();
          },
          child: Container(
            width: 300,
            height: 300,
            child: Fragments(
              fragmentsController: controller,
              startingOffset: startingPoint,
              delegate: widget.delegate,
              child: FragmentsExample(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => controller.start(),
      ),
    );
  }
}
