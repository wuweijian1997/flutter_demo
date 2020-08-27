import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    /// 亮度模式:暗黑模式和亮度模式
    brightness: Brightness.light,
    /// 主题色((包含了primaryColor和accentColor)
    primarySwatch: Colors.pink,
    ///导航和tabBar的颜色
    primaryColor: Colors.orange,
    /// 单独设置FloatingActionButton\Switch
    accentColor: Colors.green,
    ///button默认的buttonTheme
    buttonTheme: ButtonThemeData(height: 25, minWidth: 10, buttonColor: Colors.red),
    ///card主题
    cardTheme: CardTheme(),
    ///文字主题
    textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 30),
    ),
    platform: TargetPlatform.iOS,
  );
  static final ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.black,
      textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 20, color: Colors.red)
      )
  );
}