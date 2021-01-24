import 'dart:async';

import 'package:demo/util/log_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/index.dart';

class NavigatorUtil extends NavigatorObserver {
  static const sName = "NavigatorUtil";

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static get context => navigatorKey.currentContext;
  static NavigatorState get navigatorState => navigatorKey.currentState;


  static NavigatorUtil navigatorUtil = NavigatorUtil();

  static Map<String, WidgetBuilder> configRoutes = {
    ImageExifPage.rName: (context) => ImageExifPage(),
    CustomScrollViewPage.rName: (context) => CustomScrollViewPage(),
    InheritedWidgetDemo.rName: (context) => InheritedWidgetDemo(),
    CardSwipeWidgetDemo.rName: (context) => CardSwipeWidgetDemo(),
    AnimationPage.rName: (context) => AnimationPage(),
    AnimatedFlexPage.rName: (context) => AnimatedFlexPage(),
    CountdownTimerPage.rName: (context) => CountdownTimerPage(),
    EditImagePage.rName: (context) => EditImagePage(),
    CircularClipperPage.rName: (context) => CircularClipperPage(),
    AnimationRoutePage.rName: (context) => AnimationRoutePage(),
    CanvasPage.rName: (context) => CanvasPage(),
    CanvasDemoPage.rName: (context) => CanvasDemoPage(),
    BlendModePage.rName: (context) => BlendModePage(),
    AnimationPhysicsPage.rName: (context) => AnimationPhysicsPage(),
    ToastPage.rName: (context) => ToastPage(),
    CustomBottomBarPage.rName: (context) => CustomBottomBarPage(),
    CustomLoadingPage.rName: (context) => CustomLoadingPage(),
    ValueNotifierPage.rName: (context) => ValueNotifierPage(),
    CustomImagePage.rName: (context) => CustomImagePage(),
    CustomGestureDetectorPage.rName: (context) => CustomGestureDetectorPage(),
    CircularClipperTabPage.rName: (context) => CircularClipperTabPage(),
    RefreshPage.rName: (context) => RefreshPage(),
    AnimatedListDemoPage.rName: (context) => AnimatedListDemoPage(),
    WeChatHomeDropDown.rName: (context) => WeChatHomeDropDown(),
    SliverPersistentHeaderDelegatePage.rName: (context) => SliverPersistentHeaderDelegatePage(),
    SliverPage.rName: (context) => SliverPage(),
    SliverOverlapInjectorDemo.rName: (context) => SliverOverlapInjectorDemo(),
    SliverGeometryTestPage.rName: (context) => SliverGeometryTestPage(),
    SliverToolsPage.rName: (context) => SliverToolsPage(),
    SizeAndPositionPage.rName: (context) => SizeAndPositionPage(),
    SliverConstraintsOverlapPage.rName: (context) => SliverConstraintsOverlapPage(),
    MultiSliverDemo.rName: (context) => MultiSliverDemo(),
    SliverTestPage.rName: (context) => SliverTestPage(),
    SliverStackDemo.rName: (context) => SliverStackDemo(),
    SliverClipDemo.rName: (context) => SliverClipDemo(),
    SliverCrossAxisConstrainedDemo.rName: (context) => SliverCrossAxisConstrainedDemo(),
    SliverCrossAxisPaddedDemo.rName: (context) => SliverCrossAxisPaddedDemo(),
    RenderObjectPage.rName: (context) => RenderObjectPage(),
    WidgetDetailPage.rName: (context) => WidgetDetailPage(),
    NavigatorV2Page.rName: (context) => NavigatorV2Page(),
    RainbowTextPage.rName: (context) => RainbowTextPage(),
    ScreenshotPage.rName: (context) => ScreenshotPage(),
    FragmentsPage.rName: (context) => FragmentsPage(),
    PictureFragmentsPage.rName: (context) => PictureFragmentsPage(),
    FragmentsClipTabPage.rName: (context) => FragmentsClipTabPage(),
    NightModePage.rName: (context) => NightModePage(),
    SizeClipTabPage.rName: (context) => SizeClipTabPage(),
    BlocPage.rName: (context) => BlocPage(),
    LineBorderPage.rName: (context) => LineBorderPage(),
    NotificationDemoPage.rName: (context) => NotificationDemoPage(),
    OperationTipsPage.rName: (context) => OperationTipsPage(),
    PlatformPage.rName: (context) => PlatformPage(),
    MethodChannelPage.rName: (context) => MethodChannelPage(),
    EventChannelPage.rName: (context) => EventChannelPage(),
    BasicMessageChannelPage.rName: (context) => BasicMessageChannelPage(),
    PetListPage.rName: (context) => PetListPage(),
    AddPetPage.rName: (context) => AddPetPage(),
    IsolatePage.rName: (context) => IsolatePage(),
    ComputePage.rName: (context) => ComputePage(),
    InfiniteProcessPage.rName: (context) => InfiniteProcessPage(),
    ListViewPage.rName: (context) => ListViewPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    if (setting.name == 'pageName') {
      /*return MaterialPageRoute(builder: (ctx) {
        return ConstDemo(setting.arguments);
      });*/
    }
    return null;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings setting) {
    return MaterialPageRoute(
        builder: (ctx) {
          return UnKnowPage();
        }
    );
  }

  static NavigatorUtil navigatorUtils;
  static NavigatorState currentNavigator;
  BuildContext mContext;
  static List<Route> _mRoutes;

  Route get currentRoute => _mRoutes[_mRoutes.length - 1];

  List<Route> get routes => _mRoutes;
  static StreamController _streamController;

  static NavigatorUtil getInstance() {
    if (navigatorUtils == null) {
      navigatorUtils = new NavigatorUtil();
      _streamController = StreamController.broadcast();
    }

    return navigatorUtils;
  }

  StreamController get streamController => _streamController;

  setContext(BuildContext context) {
    mContext = context;
  }

  BuildContext getContext() {
    return mContext;
  }

  // replace 页面
  pushReplacementNamed(BuildContext context, String routeName,
      [WidgetBuilder builder]) {
    if (context != null) mContext = context;
    if (currentNavigator != null) {
      return currentNavigator.pushReplacement(
        CupertinoPageRoute(
          builder: builder ?? configRoutes[routeName],
          settings: RouteSettings(name: routeName),
        ),
      );
    }
  }

  push(BuildContext context, String routeName, [WidgetBuilder builder]) {
    if (context != null) mContext = context;
    if (currentNavigator != null) {
      return currentNavigator.push(
        CupertinoPageRoute(
          builder: builder ?? configRoutes[routeName],
          settings: RouteSettings(name: routeName),
        ),
      );
    }
  }

  // push 页面
  pushNamed(String routeName, [Object arguments]) {
    if (currentNavigator != null) {
      return currentNavigator.pushNamed(routeName, arguments: arguments);
    }
  }

  // pop 页面
  pop<T extends Object>(BuildContext context, [T result]) {
    if (context != null) mContext = context;
    Navigator.pop(context, result);
  }

  // pop页面 到routeName为止
  popUntil(BuildContext context, String routeName) {
    if (context != null) mContext = context;
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  // push一个页面， 移除该页面下面所有页面
  pushNamedAndRemoveUntil(BuildContext context, String newRouteName) {
    if (context != null) mContext = context;
    if (currentNavigator != null) {
      return currentNavigator.pushNamedAndRemoveUntil(
          newRouteName, (Route<dynamic> route) => false);
    }
  }

  @override
  void didPush(Route route, Route previousRoute) {
    // 当调用Navigator.push时回调
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    //....等等
    if (_mRoutes == null) {
      _mRoutes = new List<Route>();
    }
    if (route is CupertinoPageRoute || route is MaterialPageRoute) {
      Log.info('push: ${route.settings}', StackTrace.current);
      _mRoutes.add(route);
      routeObserver();
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace();
    if (newRoute is CupertinoPageRoute || newRoute is MaterialPageRoute) {
      Log.info('replace: ${newRoute.settings}', StackTrace.current);
      _mRoutes.remove(oldRoute);
      _mRoutes.add(newRoute);
      routeObserver();
    }
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    if (route is CupertinoPageRoute || route is MaterialPageRoute) {
      Log.info('pop: ${route.settings}', StackTrace.current);
      _mRoutes.remove(route);
      routeObserver();
    }
  }

  @override
  void didRemove(Route removedRoute, Route oldRoute) {
    super.didRemove(removedRoute, oldRoute);
    if (removedRoute is CupertinoPageRoute ||
        removedRoute is MaterialPageRoute) {
      Log.info('remove: ${removedRoute.settings}', StackTrace.current);
      _mRoutes.remove(removedRoute);
      routeObserver();
    }
  }

  void routeObserver() {
    // 当前页面的navigator
    currentNavigator = _mRoutes[_mRoutes.length - 1].navigator;
//    StatusBarUtil.setupStatusBar(_mRoutes[_mRoutes.length - 1]);
    _emitListener();
  }

  _emitListener() {
    streamController.sink.add(_mRoutes);
  }

  dispose() {
    _streamController.close();
  }
}
