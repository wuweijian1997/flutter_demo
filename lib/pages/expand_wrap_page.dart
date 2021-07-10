import 'package:demo/util/assets_util.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class ExpandWrapPage extends StatefulWidget {
  static String rName = 'ExpandWrapPage';

  const ExpandWrapPage({Key? key}) : super(key: key);

  @override
  _ExpandWrapPageState createState() => _ExpandWrapPageState();
}

class _ExpandWrapPageState extends State<ExpandWrapPage> {
  List<String> list = [
    'AAA',
    'BBBB',
    'c',
    'DDDDDD',
    'ASDFASDF',
    'AASD',
    'UUU',
    'PPPPP',
    'SSS',
    'ASDFSADF'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandWrap(
        children: buildChildren(),
        line: 2,
      ),
    );
  }

  buildChildren() {
    return list
        .map((e) => Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              e,
              style: TextStyle(fontSize: 28, backgroundColor: Colors.blue),
            )))
        .toList(growable: false);
  }
}
