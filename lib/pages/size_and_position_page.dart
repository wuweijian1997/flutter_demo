import 'package:flutter/material.dart';

class SizeAndPositionPage extends StatefulWidget {
  static const rName = 'Size&Position';

  @override
  _SizeAndPositionState createState() => _SizeAndPositionState();
}

class _SizeAndPositionState extends State<SizeAndPositionPage> {
  GlobalKey _key = GlobalKey();
  Size size;
  Offset offset;

  getValue() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    setState(() {
      size = renderBox.size;
      offset = renderBox.localToGlobal(Offset.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Container(
          key: _key,
          width: 200,
          height: 200,
          color: Colors.red,
          alignment: Alignment.center,
          child: Text('$size\n$offset', style: TextStyle(fontSize: 20),),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: getValue,
      ),
    );
  }
}
