import 'package:demo/pages/platform_view/hybrid_view.dart';
import 'package:demo/pages/platform_view/virtual_view.dart';
import 'package:flutter/material.dart';

class PlatformViewsPage extends StatefulWidget {
  static const rName = "PlatformViews";

  const PlatformViewsPage({Key? key}) : super(key: key);

  @override
  State<PlatformViewsPage> createState() => _PlatformViewsPageState();
}

class _PlatformViewsPageState extends State<PlatformViewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PlatformView"),
      ),
      body: Column(
        children: const [
          SizedBox(height: 300, child: HybridView()),
          SizedBox(height: 300, child: VirtualView()),
        ],
      ),
    );
  }
}
