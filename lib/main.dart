import 'dart:math';
import 'dart:ui';

import 'package:demo/model/index.dart';
import 'package:demo/navigator_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

import 'effect/index.dart';
import 'pages/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  /// [ 异常捕获 ]
  /*FlutterError.onError = (FlutterErrorDetails details) {
    LogUtil.info("[ FlutterError.onError ] = ${details.library}, $details", StackTrace.current);
  };*/

  /// 设置状态栏颜色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  SizeFit.init();
  /* runZoned(() {*/
  runApp(MultiProvider(
      providers: providers,
      child: MyApp(),
    ));
/*  }, onError: (Object obj, StackTrace stack) {
    Log.info("[ runZoned onError ] = $obj, $stack", stack);
  });*/
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorUtil.navigatorKey,
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
    _HomePageItem(page: ImageExifPage.rName),
    _HomePageItem(page: CustomScrollViewPage.rName),
    _HomePageItem(page: InheritedWidgetDemo.rName),
    _HomePageItem(page: CardSwipeWidgetDemo.rName),
    _HomePageItem(page: AnimationPage.rName),
    _HomePageItem(page: AnimatedFlexPage.rName),
    _HomePageItem(page: CountdownTimerPage.rName),
    _HomePageItem(page: EditImagePage.rName),
    _HomePageItem(page: CircularClipperPage.rName),
    _HomePageItem(page: AnimationRoutePage.rName),
    _HomePageItem(page: CanvasPage.rName),
    _HomePageItem(page: BlendModePage.rName),
    _HomePageItem(page: AnimationPhysicsPage.rName),
    _HomePageItem(page: ToastPage.rName),
    _HomePageItem(page: CustomBottomBarPage.rName),
    _HomePageItem(page: CustomLoadingPage.rName),
    _HomePageItem(page: ValueNotifierPage.rName),
    _HomePageItem(page: CustomImagePage.rName),
    _HomePageItem(page: CustomGestureDetectorPage.rName),
    _HomePageItem(page: CircularClipperTabPage.rName),
    _HomePageItem(page: AnimatedListDemoPage.rName),
    _HomePageItem(page: SliverPage.rName),
    _HomePageItem(page: SizeAndPositionPage.rName),
    _HomePageItem(page: RenderObjectPage.rName),
    _HomePageItem(page: NavigatorV2Page.rName),
    _HomePageItem(page: RainbowTextPage.rName),
    _HomePageItem(page: ScreenshotPage.rName),
    _HomePageItem(page: FragmentsPage.rName),
    _HomePageItem(page: PictureFragmentsPage.rName),
    _HomePageItem(page: FragmentsClipTabPage.rName),
    _HomePageItem(page: NightModePage.rName),
    _HomePageItem(page: SizeClipTabPage.rName),
    _HomePageItem(page: BlocPage.rName),
    _HomePageItem(page: LineBorderPage.rName),
    _HomePageItem(page: NotificationDemoPage.rName),
    _HomePageItem(page: OperationTipsPage.rName),
    _HomePageItem(page: PlatformPage.rName),
    _HomePageItem(page: IsolatePage.rName),
    _HomePageItem(page: ListViewPage.rName),
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
              padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
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
                      NavigatorUtil.getInstance()
                          .pushNamed(homeList[index].page);
                    },
                  );
                },
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
                childAspectRatio: 1.5,
              ),
            ))
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

  _HomePageItem({title, this.page}) : this.title = title ?? page;
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key key,
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
    MaterialColor _bgColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];

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
                      child: FittedBox(
                        fit: BoxFit.contain,
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
          ),
        );
      },
    );
  }
}
