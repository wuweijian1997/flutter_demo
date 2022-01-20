import 'package:demo/model/index.dart';
import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class Const {
  ///bubble(变化值)
  ///气泡个数
  static const bubbleCount = 20;

  ///气泡透明度
  static const bubbleMinOpacity = 0.1;
  static const bubbleMaxOpacity = 0.2;

  ///移动加速度accelerate
  static const bubbleMinAccelerate = 0.01;
  static const bubbleMaxAccelerate = 0.06;

  ///气泡半径
  static const bubbleMinRadius = 30.0;
  static const bubbleMaxRadius = 60.0;

  ///气泡水平移动距离
  static const bubbleMinMoveX = 0.5;
  static const bubbleMaxMoveX = 1.0;

  ///气泡垂直移动距离
  static const bubbleMinMoveY = 1.0;
  static const bubbleMaxMoveY = 2.0;

  ///背景渐变颜色
  static const bubbleBgColorStart = Colors.blue;
  static const bubbleBgColorEnd = Colors.red;

  static Widget buildSliverList({int count = 0}) {
    return SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          //创建列表项
          return Container(
            alignment: Alignment.center,
            color: Colors.teal[100 * (index % 10)],
            child: Text('list item $index, height: 50'),
          );
        },
        childCount: count,
      ),
    );
  }

  static List<ClipTabModel> pages = [
    ClipTabModel(
        color: const Color(0xFFcd344f),
        image: Assets.rem,
        title: 'This is first page!'),
    ClipTabModel(
        color: const Color(0xFF638de3),
        image: Assets.rem02,
        title: 'This is second page!'),
    ClipTabModel(
        color: const Color(0xFFFF682D),
        image: Assets.eat_cape_town_sm,
        title: 'This is third page!'),
  ];
}
