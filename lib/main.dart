import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:demo/NavigatorUtil.dart';
import 'package:demo/model/index.dart';
import 'package:demo/pages/AnimatedSwitcherPage.dart';
import 'package:demo/pages/AnimationPage.dart';
import 'package:demo/pages/ClipPage.dart';
import 'package:demo/pages/ConstrainedBoxPage.dart';
import 'package:demo/pages/ContainerPage.dart';
import 'package:demo/pages/CustomScrollViewPage.dart';
import 'package:demo/pages/DecoratedBoxPage.dart';
import 'package:demo/pages/GestureDetectorPage.dart';
import 'package:demo/pages/ImageExif.dart';
import 'package:demo/pages/LayoutConstraints.dart';
import 'package:demo/pages/Padding.dart';
import 'package:demo/pages/ProviderFirstPage.dart';
import 'package:demo/pages/SingleChildScrollViewPage.dart';
import 'package:demo/pages/TabBarDemo.dart';
import 'package:demo/pages/TransformPage.dart';
import 'package:demo/pages/Wrap.dart';
import 'package:demo/pages/card_swipe_page.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/shared/index.dart';
import 'package:demo/util/log_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/HeroPage.dart';
import 'pages/index.dart';
import 'extension/index.dart';

void main() {
  /// [ 异常捕获 ]
  FlutterError.onError = (FlutterErrorDetails details) {
    LogUtil.e("[ FlutterError.onError ] = ", details.library, details);
  };

  SizeFit.init();
  var width = 100.px;
  var width2 = 100.0.px;
  runZoned(() {
    runApp(MultiProvider(
      providers: providers,
      child: MyApp(),
    ));
  }, onError: (Object obj, StackTrace stack) {
    LogUtil.e("[ runZoned onError ] = ", obj, stack);
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaterialApp title',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: NavigatorUtil.configRoutes,
      navigatorObservers: [
        NavigatorUtil.getInstance(),
      ],

      ///Navigator.of(context).pushNamed(routeName, arguments: 'pageParams');
      ///命名路由传参方式
      onGenerateRoute: NavigatorUtil.onGenerateRoute,

      ///路由错误页面
      onUnknownRoute: NavigatorUtil.onUnknownRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  static List<_HomePageItem> homeList = [
    _HomePageItem(title: WrapPage.rName, page: WrapPage.rName),
    _HomePageItem(title: PaddingPage.rName, page: PaddingPage.rName),
    _HomePageItem(
        title: ConstrainedBoxPage.rName, page: ConstrainedBoxPage.rName),
    _HomePageItem(title: DecoratedBoxPage.rName, page: DecoratedBoxPage.rName),
    _HomePageItem(title: TransformPage.rName, page: TransformPage.rName),
    _HomePageItem(title: ContainerPage.rName, page: ContainerPage.rName),
    _HomePageItem(title: ClipPage.rName, page: ClipPage.rName),
    _HomePageItem(
        title: SingleChildScrollViewPage.rName,
        page: SingleChildScrollViewPage.rName),
    _HomePageItem(
        title: GestureDetectorPage.rName, page: GestureDetectorPage.rName),
    _HomePageItem(
        title: LayoutConstraints.rName, page: LayoutConstraints.rName),
    _HomePageItem(
        title: ProviderFirstPage.rName, page: ProviderFirstPage.rName),
    _HomePageItem(title: ImageExifPage.rName, page: ImageExifPage.rName),
    _HomePageItem(title: AnimationPage.rName, page: AnimationPage.rName),
    _HomePageItem(title: HeroPage.rName, page: HeroPage.rName),
    _HomePageItem(title: AnimatedSwitcherCounterRoute.rName,
        page: AnimatedSwitcherCounterRoute.rName),
    _HomePageItem(title: TabBarDemo.rName, page: TabBarDemo.rName),
    _HomePageItem(
        title: CustomScrollViewPage.rName, page: CustomScrollViewPage.rName),
    _HomePageItem(title: CustomPaintPage.rName, page: CustomPaintPage.rName),
    _HomePageItem(title: ListViewPage.rName, page: ListViewPage.rName),
    _HomePageItem(title: PointerEventPage.rName, page: PointerEventPage.rName),
    _HomePageItem(title: ScrollViewListenerDemoPage.rName,
        page: ScrollViewListenerDemoPage.rName),
    _HomePageItem(title: CardSwipeDemo.rName, page: CardSwipeDemo.rName),
    _HomePageItem(
        title: InheritedWidgetDemo.rName, page: InheritedWidgetDemo.rName),
    _HomePageItem(title: ConstDemo.rName, page: ConstDemo.rName),
    _HomePageItem(
        title: CardSwipeWidgetDemo.rName, page: CardSwipeWidgetDemo.rName),
    _HomePageItem(title: AnimationDemo.rName, page: AnimationDemo.rName),
    _HomePageItem(title: PointDemoPage.rName, page: PointDemoPage.rName),
    _HomePageItem(title: EventBusDemoPage.rName, page: EventBusDemoPage.rName),
    _HomePageItem(title: AnimationPage2.rName, page: AnimationPage2.rName),
    _HomePageItem(title: ThemeDemo.rName, page: ThemeDemo.rName),
    _HomePageItem(title: AnimationPageMixinPage.rName, page: AnimationPageMixinPage.rName),
    _HomePageItem(title: AnimatedListSample.rName, page: AnimatedListSample.rName),
    _HomePageItem(title: CountdownTimerPage.rName, page: CountdownTimerPage.rName),
    _HomePageItem(title: CanvasDrawImage.rName, page: CanvasDrawImage.rName),
  ];

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: GridView(
                  padding: const EdgeInsets.only(
                      top: 0, left: 12, right: 12),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: List<Widget>.generate(
                    homeList.length,
                        (int index) {
                      final int count = homeList.length;
                      final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController.forward();
                      return HomeListView(
                        animation: animation,
                        animationController: animationController,
                        listData: homeList[index],
                        callBack: () {
                          NavigatorUtil.getInstance().pushNamed(
                              context, homeList[index].page);
                        },
                      );
                    },
                  ),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 1.5,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("main didChangeDependencies");
  }
}

class _HomePageItem {
  String title;
  String page;

  _HomePageItem({this.title, this.page});
}


class HomeListView extends StatelessWidget {
  const HomeListView({Key key,
    this.listData,
    this.callBack,
    this.animationController,
    this.animation})
      : super(key: key);

  final _HomePageItem listData;
  final VoidCallback callBack;
  final AnimationController animationController;
  final Animation<dynamic> animation;


  @override
  Widget build(BuildContext context) {
    MaterialColor _bgColor = Colors.primaries[Random().nextInt(
        Colors.primaries.length)];

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: GestureDetector(
                  onTap: callBack,
                  child: Container(
                    color: _bgColor,
                    child: Center(
                      child: Text(
                        listData.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
