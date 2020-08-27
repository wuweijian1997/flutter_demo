import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StarRating extends StatefulWidget {
  final double rating;
  final double maxRating;
  final int count;
  final double size;
  final Color unselectedColor;
  final Color selectedColor;
  final Widget unselectedWidget;
  final Widget selectedWidget;

  StarRating({
    @required double rating,
    this.maxRating = 10,
    this.count = 5,
    this.size = 30,
    this.unselectedColor = Colors.grey,
    this.selectedColor = Colors.red,
    Widget selectedWidget,
    Widget unselectedWidget,
  })  : unselectedWidget = unselectedWidget ??
            Icon(
              Icons.star_border,
              color: unselectedColor,
              size: size,
            ),
        selectedWidget = selectedWidget ??
            Icon(
              Icons.star,
              color: selectedColor,
              size: size,
            ),
        rating = min(rating, maxRating);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildUnselectedStar(),
        ),
        Row(mainAxisSize: MainAxisSize.min, children: _buildSelectedStar()),
      ],
    );
  }

  List<Widget> _buildUnselectedStar() {
    return List.generate(widget.count, (index) {
      return widget.unselectedWidget;
    });
  }

  List<Widget> _buildSelectedStar() {
    //创建stars
    List<Widget> stars = [];
    final star = widget.selectedWidget;
    //构建满的star
    double oneValue = widget.maxRating / widget.count;
    int entireCount = (widget.rating / oneValue).floor();
    for (int i = 0; i < entireCount; i++) {
      stars.add(star);
    }
    //构建部分填充star
    double leftWidth = (widget.rating / oneValue - entireCount) * widget.size;
    stars.add(ClipRect(
      clipper: StarClipper(width: leftWidth),
      child: star,
    ));
    return stars;
  }
}

class StarClipper extends CustomClipper<Rect> {
  double width;

  StarClipper({this.width = 0});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(StarClipper oldClipper) {
    return width != oldClipper.width;
  }
}
