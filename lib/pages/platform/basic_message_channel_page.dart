
import 'dart:typed_data';

import 'package:demo/platform/index.dart';
import 'package:flutter/material.dart';

class BasicMessageChannelPage extends StatefulWidget {
  static const String rName = "BasicMessageChannel";

  const BasicMessageChannelPage({Key? key}) : super(key: key);

  @override
  _BasicMessageChannelPageState createState() =>
      _BasicMessageChannelPageState();
}

class _BasicMessageChannelPageState extends State<BasicMessageChannelPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: NativeImage("rem.jpg"),
      ),
    );
  }
}

class NativeImage extends StatelessWidget {
  final String assetName;

  const NativeImage(this.assetName, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: FlutterBasicMessageChannel.assets(assetName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
