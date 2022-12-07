import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VirtualView extends StatefulWidget {
  const VirtualView({Key? key}) : super(key: key);

  @override
  State<VirtualView> createState() => _VirtualViewState();
}

class _VirtualViewState extends State<VirtualView> {
  @override
  Widget build(BuildContext context) {
    return  const AndroidView(
      viewType: "<platform-virtual-view>",
      layoutDirection: TextDirection.ltr,
      creationParams: <String,dynamic>{},
      creationParamsCodec: StandardMessageCodec(),
    );
  }
}
