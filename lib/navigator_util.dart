import 'dart:async';

import 'package:demo/util/log_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/index.dart';

class NavigatorUtil extends NavigatorObserver {
  static const sName = "NavigatorUtil";

  static NavigatorUtil navigatorUtil = NavigatorUtil();

  static Map<String, WidgetBuilder> configRoutes = {
    TransformPage.rName: (context) => TransformPage(),
    ImageExifPage.rName: (context) => ImageExifPage(),
    CustomScrollViewPage.rName: (context) => CustomScrollViewPage(),
    ScrollViewListenerDemoPage.rName: (context) => ScrollViewListenerDemoPage(),
    CardSwipeDemo.rName: (context) => CardSwipeDemo(),
    InheritedWidgetDemo.rName: (context) => InheritedWidgetDemo(),
    ConstDemo.rName: (context) => const ConstDemo(),
    CardSwipeWidgetDemo.rName: (context) => CardSwipeWidgetDemo(),
    AnimationPage2.rName: (context) => AnimationPage2(),
    AnimatedFlexPage.rName: (context) => AnimatedFlexPage(),
    CountdownTimerPage.rName: (context) => CountdownTimerPage(),
    CanvasDrawImage.rName: (context) => CanvasDrawImage(),
    EditImagePage.rName: (context) => EditImagePage(),
    CircularClipperPage.rName: (context) => CircularClipperPage(),
    AnimationRoutePage.rName: (context) => AnimationRoutePage(),
    CanvasPage.rName: (context) => CanvasPage(),
    CanvasDemoPage.rName: (context) => CanvasDemoPage(),
    BlendModePage.rName: (context) => BlendModePage(),
    AnimationPhysicsPage.rName: (context) => AnimationPhysicsPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    if (setting.name == 'pageName') {
      return MaterialPageRoute(builder: (ctx) {
        return ConstDemo(setting.arguments);
      });
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
  pushNamed(BuildContext context, String routeName, [Object arguments]) {
    if (context != null) mContext = context;
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
      LogUtil.i(sName, '^^^^routePush');
      LogUtil.i(sName, route.settings.name);
      _mRoutes.add(route);
      routeObserver();
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace();
    if (newRoute is CupertinoPageRoute || newRoute is MaterialPageRoute) {
      LogUtil.i(sName, '^^^^routeReplace');
      LogUtil.i(sName, newRoute.settings.name);
      _mRoutes.remove(oldRoute);
      _mRoutes.add(newRoute);
      routeObserver();
    }
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    if (route is CupertinoPageRoute || route is MaterialPageRoute) {
      LogUtil.i(sName, '^^^^routePop');
      LogUtil.i(sName, route.settings.name);
      _mRoutes.remove(route);
      routeObserver();
    }
  }

  @override
  void didRemove(Route removedRoute, Route oldRoute) {
    super.didRemove(removedRoute, oldRoute);
    if (removedRoute is CupertinoPageRoute ||
        removedRoute is MaterialPageRoute) {
      LogUtil.i(sName, '^^^^routeRemove');
      LogUtil.i(sName, removedRoute.settings.name);
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
}
