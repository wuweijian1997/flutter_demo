import 'package:flutter/material.dart';

class WrapPage extends StatelessWidget {
  static const rName = 'WrapPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wrap'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Wrap(
            children: _list(),
          ),
        ),
      ),
    );
  }

  List<Widget> _list() {
    List<Widget> list = new List();
    Padding c = Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          color: Colors.red,
          width: 50,
          height: 50,
        ));
    for (int i = 0; i < 10; i++) {
      list.add(c);
    }
    return list;
  }
}
