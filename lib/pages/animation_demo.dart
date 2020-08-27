import 'package:flutter/material.dart';

class AnimationDemo extends StatelessWidget {
  static const rName = 'animation_demo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LogoApp(),
    );
  }
}

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  Animation<double> animation2;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          controller.reverse();
        } else if (state == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    animation2 = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedLogo(
          animation: animation,
          child: FlutterLogoDemo(),
        ),
        AnimatedLogo2(
          animation: animation2,
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends StatelessWidget {
  AnimatedLogo({Key key, this.animation, this.child});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    print('kafka AnimatedLogo');
    return Center(
        child: AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
          child: child,
        );
      },
      child: FlutterLogoDemo(),
    ));
  }
}

class FlutterLogoDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('kafka FlutterLogoDemo');
    return FlutterLogo();
  }
}

class AnimatedLogo2 extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  AnimatedLogo2({Key key, Animation<double> animation}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
//          height: _sizeTween.evaluate(animation),
//          width: _sizeTween.evaluate(animation),
          width: 100,
          height: 100,
          child: Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      offset: Offset(0, 6),
                      blurRadius: 10  )
                ],
                color: Colors.red,
              ),
              child: InkWell(
                onTap: () {
                  print('InkWell');
                },
                child: FlutterLogo(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
