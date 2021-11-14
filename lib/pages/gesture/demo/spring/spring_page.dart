import 'package:demo/pages/gesture/demo/spring/spring_widget.dart';
import 'package:flutter/material.dart';

class SpringPage extends StatefulWidget {
  const SpringPage({Key? key}) : super(key: key);

  @override
  _SpringPageState createState() => _SpringPageState();
}

class _SpringPageState extends State<SpringPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SpringWidget(),
    );
  }
}
