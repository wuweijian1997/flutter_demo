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
        button: const SizedBox(),
      ),
    );
  }

  buildChildren() {
    return list
        .map((e) => Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              e,
              style: const TextStyle(fontSize: 28, backgroundColor: Colors.blue),
            )))
        .toList(growable: false);
  }
}
