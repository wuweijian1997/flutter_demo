import 'dart:typed_data';

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
