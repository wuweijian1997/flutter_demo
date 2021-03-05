import 'package:demo/model/index.dart';
import 'package:flutter/material.dart';

class ClipTabItem extends StatelessWidget {
  final ClipTabModel model;
  final double percentage;

  ClipTabItem({required this.model, this.percentage = 1, Key? key}):
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: model.color,
      height: double.infinity,
      child: Opacity(
        opacity: percentage,
        child: Container(
          alignment: Alignment.center,
          transform: Matrix4.translationValues(0, 20 * (1 - percentage), 0.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
            model.image,
          ))),
          child: Text(model.title),
        ),
      ),
    );
  }
}
