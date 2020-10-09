import 'dart:math';

import 'package:flutter/material.dart';

class CustomBottomBarPage extends StatefulWidget {
  static const rName = 'CustomBottomBar';

  @override
  _CustomBottomBarPageState createState() => _CustomBottomBarPageState();
}

class _CustomBottomBarPageState extends State<CustomBottomBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            color: Colors.blue,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: PhysicalShape(
              color: Colors.white,
              elevation: 16.0,
              clipper: TabClipper(radius: 40.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      color: Colors.red,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      color: Colors.pink,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      color: Colors.green,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      color: Colors.yellow,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipOval(
              child: Container(
                width: 70,
                height: 70,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///Tab 中间凹形裁剪
class TabClipper extends CustomClipper<Path> {
  TabClipper({@required this.radius});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double v = radius * 2;

    ///左上角
    path.lineTo(0, 0);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2 + 20, v, v),
        degreeToRadians(210), degreeToRadians(120), false);

    ///右上角
    path.lineTo(size.width, 0);

    ///右下角
    path.lineTo(size.width, size.height);

    ///左下角
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    final double redian = (pi / 180) * degree;
    return redian;
  }
}
