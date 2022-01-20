import 'dart:math';
import 'package:demo/navigator_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'effect/index.dart';
import 'model/counter_model.dart';
import 'pages/index.dart';

///flutter run --no-sound-null-safety
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb == false) {
    HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());
  }

  /// 设置状态栏颜色
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  SizeFit.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => CounterModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorUtil.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'MaterialApp title',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  const MyHomePage({Key? key, this.title = 'Demo'}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static List<_HomePageItem> homeList = [
    _HomePageItem(page: CustomScrollViewPage.rName),
    _HomePageItem(page: InheritedWidgetDemo.rName),
    _HomePageItem(page: CardSwipeWidgetDemo.rName),
    _HomePageItem(page: AnimationPage.rName),
    _HomePageItem(page: CircularClipperPage.rName),
    _HomePageItem(page: AnimationRoutePage.rName),
    _HomePageItem(page: CanvasPage.rName),
    _HomePageItem(page: BlendModePage.rName),
    _HomePageItem(page: AnimationPhysicsPage.rName),
    _HomePageItem(page: ToastPage.rName),
    _HomePageItem(page: CustomImagePage.rName),
    _HomePageItem(page: CustomGestureDetectorPage.rName),
    _HomePageItem(page: AnimatedListDemoPage.rName),
    _HomePageItem(page: SliverPage.rName),
    _HomePageItem(page: SizeAndPositionPage.rName),
    _HomePageItem(page: RenderObjectPage.rName),
    _HomePageItem(page: NavigatorV2Page.rName),
    _HomePageItem(page: RainbowTextPage.rName),
    _HomePageItem(page: ScreenshotPage.rName),
    _HomePageItem(page: FragmentsPage.rName),
    _HomePageItem(page: PictureFragmentsPage.rName),
    _HomePageItem(page: NightModePage.rName),
    _HomePageItem(page: BlocPage.rName),
    _HomePageItem(page: LineBorderPage.rName),
    _HomePageItem(page: NotificationDemoPage.rName),
    _HomePageItem(page: OperationTipsPage.rName),
    _HomePageItem(page: PlatformPage.rName),
    _HomePageItem(page: IsolatePage.rName),
    _HomePageItem(page: ClipTab.rName),
    _HomePageItem(page: AllShadowsPage.rName),
    _HomePageItem(page: ClampingCustomScrollViewPage.rName),
    _HomePageItem(page: ExpandWrapPage.rName),
    _HomePageItem(page: GesturePage.rName),
  ];

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                  MaterialColor color =
                  Colors.primaries[Random().nextInt(Colors.primaries.length)];
                  return HomeCard(
                    color: color,
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
}

class _HomePageItem {
  String title;
  String page;

  _HomePageItem({title, this.page = ''}) : title = title ?? page;
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.listData,
    required this.callBack,
    required this.animationController,
    required this.animation,
    required this.color,
  }) : super(key: key);

  final _HomePageItem listData;
  final VoidCallback callBack;
  final AnimationController animationController;
  final Animation<double> animation;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: child,
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1.5,
        child: GestureDetector(
          onTap: callBack,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                listData.title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
