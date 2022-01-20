import 'package:flutter/material.dart';

class UnKnowPage extends StatelessWidget {
  static String rName = 'UnKnow';

  const UnKnowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('错误页面'),),
      body: const Center(
        child: Text('错误页面'),
      ),
    );
  }
}
