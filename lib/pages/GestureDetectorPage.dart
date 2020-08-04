import 'package:flutter/material.dart';

class GestureDetectorPage extends StatefulWidget {
  static const rName = 'GestureDetectorPage';

  @override
  _GestureDetectorPageState createState() => _GestureDetectorPageState();
}

class _GestureDetectorPageState extends State<GestureDetectorPage> {
  double left = 20, top = 30;
  Offset offset = Offset.zero;

  double rotate = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('提示'),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Stack(children: <Widget>[
          Positioned(
            left: left,
            top: top,
//          child: Text("Demo"),
            child: GestureDetector(
              onHorizontalDragUpdate: this.renderPanUpdate,
              onHorizontalDragEnd: this.renderPanEnd,
              child: Transform.rotate(
                angle: rotate,
                child: Container(
                  child: Text("Demo"),
                  height: 600,
                  width: 350,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  renderPanUpdate(DragUpdateDetails e) {
    setState(() {
      top += e.delta.dy;
      left += e.delta.dx;
    });
    print({
      "top": top,
      "left": left,
    });
  }

  void renderPanEnd(DragEndDetails details) {
    print({"top": top, "left": left});
    // left 130
    if(left < 150 && left > -110) {
      setState(() {
        left = 20.0;
      });
    }
  }
}
