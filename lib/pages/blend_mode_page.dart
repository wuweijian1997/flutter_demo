import 'package:flutter/material.dart';

class BlendModePage extends StatefulWidget {
  static const rName = 'BlendModePage';

  @override
  _BlendModePageState createState() => _BlendModePageState();
}

class _BlendModePageState extends State<BlendModePage> with TickerProviderStateMixin {

  final tabs = [
    const Tab(
      text: 'TransparentText',
    ),
    const Tab(
      text: 'GradientText',
    ),
    const Tab(
      text: 'AnimationGradientText',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: [
            TransparentText(),
            GradientText(),
            AnimationGradientText(),
          ],
        ),
      ),
    );
  }
}

class TransparentText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/rem.jpg'))),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: ShaderMask(
          blendMode: BlendMode.srcOut,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [Colors.black, Colors.black],
            ).createShader(bounds);
          },
          child: Container(
            width: double.infinity,
            height: 50,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              'Hello World',
              style: Theme.of(context).textTheme.headline4.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [Colors.green, Colors.blue],
          ).createShader(bounds);
        },
        child: Text(
          'Hello World',
          style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white,),
        ),
      ),
    );
  }
}

class AnimationGradientText extends StatefulWidget {
  @override
  _AnimationGradientTextState createState() => _AnimationGradientTextState();
}

class _AnimationGradientTextState extends State<AnimationGradientText> with SingleTickerProviderStateMixin{
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.forward(from: 0);
      }
    });
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [Colors.red, Colors.red, Colors.blue, Colors.blue],
                    stops: [0, controller.value, controller.value, 1],
                  ).createShader(bounds);
                },
                child: FittedBox(
                  child: Text(
                    '落霞与孤鹜齐飞,秋水共长天一色',
                    style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white,),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
