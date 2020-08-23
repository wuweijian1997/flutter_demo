import 'dart:math';

import 'package:demo/pages/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationPage2 extends StatefulWidget {
  static const rName = 'Animation';

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

/// 1.Animation: 抽象类
///           监听动画值的改变
///           监听动画状态的改变
///           value当前动画值
///           status当前动画状态
/// 2.AnimationController: 继承自Animation
///           vsync:同步信号,切换到后台或锁屏会停止渲染动画
/// 3.CurvedAnimation:
///           设置动画执行的速率(速度曲线)
/// 4.Tween:设置动画执行的value范围
///           begin:开始值
///           end:结束值
///
/// 优化方案:  AnimatedWidget
///             - 将需要执行动画的widget放到一个AnimationWidget中的build方法里进行返回
///             - 缺点:
///               1:每次都要创建一个类
///               2:如果构建的widget有子类,子类还是会重新构建
///           AnimatedBuilder
class _AnimationPageState extends State<AnimationPage2>
    with SingleTickerProviderStateMixin {
  ///创建AnimationController

  AnimationController controller;
  Animation animation;
  Animation sizeAnimation;
  Animation colorAnimation;
  Animation opacityAnimation;
  Animation radiusAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 3,
      ),
    );

    ///设置curve的值
    animation = CurvedAnimation(parent: controller, curve: Curves.elasticIn);

    ///设置动画插值
    animation = Tween<double>(begin: 50, end: 100).animate(animation);
    ///大小的animation
    sizeAnimation = Tween<double>(begin: 50, end: 100).animate(controller);
    ///颜色animation
    colorAnimation = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);
    ///角度 animation
    radiusAnimation = Tween<double>(begin: 0, end: pi).animate(controller);
    ///设置透明度 animation
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    ///开始动画
    controller.forward();
/*    controller.addListener(() {
      setState(() {});
    });*/

    ///监听动画的改变
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: animation.value,
              ),
              IconAnimatedWidget(
                sizeAnimation: animation,
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (ctx, child) {
                  return Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: animation.value,
                  );
                },
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (ctx, child) {
                  print(opacityAnimation.value);
                  return Opacity(
                    opacity: opacityAnimation.value,
                    child: Transform(
                      transform: Matrix4.rotationZ(radiusAnimation.value),
                      alignment: Alignment.center,
                      child: Container(
                        width: sizeAnimation.value,
                        height: sizeAnimation.value,
                        color: colorAnimation.value,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          ///页面切换路由
          Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: Duration(seconds: 3),
            pageBuilder: (ctx, animation1, animation2) {
              return FadeTransition(
                  opacity: animation1,
                  child: ConstDemo());
            }
          ));
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class IconAnimatedWidget extends AnimatedWidget {
  final Animation sizeAnimation;

  IconAnimatedWidget({this.sizeAnimation}) : super(listenable: sizeAnimation);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite,
      color: Colors.red,
      size: sizeAnimation.value,
    );
  }
}
