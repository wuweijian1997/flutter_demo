import 'package:demo/NavigatorUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'HeroPage.dart';
import 'SingleChildScrollViewPage.dart';

class AnimationPage extends StatefulWidget {
  static const rName = 'AnimationPage';

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child) {
              return Container(
                color: Colors.pink,
                height: animation.value,
                width: animation.value,
              );
            },
          ),
          Hero(
              tag:
                  'https://c-ssl.duitang.com/uploads/item/201609/23/20160923211308_ic4kG.png',
              child: Image.network(
                'https://c-ssl.duitang.com/uploads/item/201609/23/20160923211308_ic4kG.png',
                width: 100,
                height: 100,
              )),
          GestureDetector(
            onTap: _handleAnimationStar,
            child: Text(
              '动画开始',
//            style: TextStyle(
//              decoration: TextDecoration.none
//            ),
            ),
          ),
          GestureDetector(
            onTap: _handleAnimationReset,
            child: Text(
              '动画重置',
              style: TextStyle(decoration: TextDecoration.none),
            ),
          ),
          GestureDetector(
            onTap: _handleAnimationRouter,
            child: Text(
              '路由动画',
              style: TextStyle(decoration: TextDecoration.none),
            ),
          ),
          GestureDetector(
            onTap: _handleHeroAnimation,
            child: Text(
              'Hero动画',
              style: TextStyle(decoration: TextDecoration.none),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAnimationStar() {
    controller.forward();
  }

  void _handleAnimationReset() {
    controller.reverse();
  }

  void _handleAnimationRouter() {
    Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return FadeTransition(
              //使用渐隐渐入过渡,
              opacity: animation,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 500 * (1.0 - animation.value), 0.0),
                  child: SingleChildScrollViewPage()), //路由B
            );
          },
        ));
  }

  void _handleHeroAnimation() {
    NavigatorUtil.getInstance().pushNamed(context, HeroPage.rName);
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition(this.child, this.animation);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext context, Widget child) {
        return Container(
          color: Colors.pink,
          height: animation.value,
          width: animation.value,
          child: child,
        );
      },
    );
  }
}
