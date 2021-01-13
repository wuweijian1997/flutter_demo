import 'dart:typed_data';

import 'package:demo/platform/index.dart';
import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class BasicMessageChannelPage extends StatefulWidget {
  static const String rName = "BasicMessageChannel";
  @override
  _BasicMessageChannelPageState createState() => _BasicMessageChannelPageState();
}

class _BasicMessageChannelPageState extends State<BasicMessageChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NativeImage("rem"),
      ),
    );
  }
}

class NativeImage extends StatefulWidget {
  final String assetName;

  NativeImage(this.assetName);

  @override
  _NativeImageState createState() => _NativeImageState();
}

class _NativeImageState extends State<NativeImage> {
  Uint8List uint8list;
  @override
  Widget build(BuildContext context) {
    if(uint8list != null) {
      return Image.memory(uint8list);
    } else {
      return SizedBox();
    }
  }

  @override
  void initState() {
    super.initState();
    this.initImage();
  }

  initImage() async {
    uint8list = await FlutterBasicMessageChannel.assets(widget.assetName);
    if(uint8list != null) {
      setState(() {
      });
    }
  }
}