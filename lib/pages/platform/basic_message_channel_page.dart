
import 'package:demo/platform/index.dart';
import 'package:flutter/material.dart';

class BasicMessageChannelPage extends StatefulWidget {
  static const String rName = "BasicMessageChannel";

  @override
  _BasicMessageChannelPageState createState() =>
      _BasicMessageChannelPageState();
}

class _BasicMessageChannelPageState extends State<BasicMessageChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NativeImage("rem.jpg"),
      ),
    );
  }
}

class NativeImage extends StatelessWidget {
  final String assetName;

  NativeImage(this.assetName);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterBasicMessageChannel.assets(assetName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Image.memory(snapshot.data);
        } else {
          return SizedBox();
        }
      },
    );
  }
}
