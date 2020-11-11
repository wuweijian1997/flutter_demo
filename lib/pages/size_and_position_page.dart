import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class SizeAndPositionPage extends StatefulWidget {
  static const rName = 'Size&Position';

  @override
  _SizeAndPositionState createState() => _SizeAndPositionState();
}

class _SizeAndPositionState extends State<SizeAndPositionPage> {
  GlobalKey _key = GlobalKey();
  Size size;
  Size textSize;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              key: _key,
              width: 200,
              height: 200,
              color: Colors.red,
              alignment: Alignment.center,
              child: Text(
                '$size\n$offset\n$textSize',
                style: TextStyle(fontSize: 20),
              ),
            ),
            RepaintBoundary(
              child: CustomPaint(
                painter: _SizePaint(
                  onSize: _getSize
                ),
                child: Container(
                  color: Colors.green,
                  child: Text(
                    'Hello World',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: getValue,
      ),
    );
  }

  void _getSize(Size value) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        textSize = value;
      });
    });
  }
}

class _SizePaint extends CustomPainter {
  Size _size = Size.zero;
  final ValueChanged<Size> onSize;

  _SizePaint({this.onSize});

  @override
  void paint(Canvas canvas, Size size) {
    Log.info('paint: $size', StackTrace.current);
    if(size != _size) {
      onSize.call(size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}