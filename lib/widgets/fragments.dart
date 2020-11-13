import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Fragments extends StatefulWidget {
  final Widget child;
  final String tag;

  Fragments({Key key, this.child, this.tag}) : super(key: key);

  @override
  _FragmentsState createState() => _FragmentsState();
}

class _FragmentsState extends State<Fragments>
    with SingleTickerProviderStateMixin {
  Size imageSize;

  ///image 的 byteData
  ByteData byteData;
  GlobalObjectKey globalKey;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    globalKey = GlobalObjectKey(widget.tag);
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
  }

  void onTap() {
    if (byteData == null || imageSize == null) {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      boundary.toImage().then((image) {
        imageSize = Size(image.width.toDouble(), image.height.toDouble());
        image.toByteData().then((data) {
          byteData = data;
          controller.forward(from: 0);
        });
      });
    } else {
      controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
