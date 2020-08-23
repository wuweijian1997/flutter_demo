import 'package:flutter/material.dart';

class PointDemoPage extends StatefulWidget {
  static String rName = 'PointDemo';

  @override
  _PointDemoPageState createState() => _PointDemoPageState();
}

class _PointDemoPageState extends State<PointDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
              child: GestureDetector(
                onTap: () {
                  print('蓝');
                },
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTapDown: (details) {
                      print('红');
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                  ),
                ),
              )),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
            GestureDetector(
              onTap: () {
                print('蓝');
              },
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                alignment: Alignment.center,
              ),
            ),
            GestureDetector(
              onTap: () {
                print('红');
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            )
          ],)
        ],
      ),
    );
  }
}

class GestureDemo extends StatelessWidget {
  const GestureDemo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
    onTapDown: (details) {
      print('手指按下');
      //全局位置
      print(details.globalPosition);
      //当前位置
      print(details.localPosition);
    },
    onTapUp: (details) {
      print('手指抬起');
    },
    onTapCancel: () {
      print('取消');
    },
    onTap: () {
      print('手势点击');
    },
    child: Container(
      width: 200,
      height: 200,
      color: Colors.pink,
    ),
        ),
      );
  }
}

class ListenerDemo extends StatelessWidget {
  const ListenerDemo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        print('onPointerDown: $event');
        print('绝对位置: ${event.position}');
        print('相对位置: ${event.localPosition}');
      },
      onPointerMove: (event) {
        print('onPointerMove: $event');
      },
      onPointerUp: (event) {
        print('onPointerUp: $event');
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
      ),
    );
  }
}
