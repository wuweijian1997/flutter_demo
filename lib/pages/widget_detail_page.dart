import 'package:flutter/material.dart';

class WidgetDetailPage extends StatelessWidget {
  static final String rName = 'WidgetDetail';

  @override
  Widget build(BuildContext context) {
    final child = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        child: child,
      ),
    );
  }
}
