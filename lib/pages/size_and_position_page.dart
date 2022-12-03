import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class SizeAndPositionPage extends StatefulWidget {
  static const rName = 'Size&Position';

  const SizeAndPositionPage({Key? key}) : super(key: key);

  @override
  _SizeAndPositionState createState() => _SizeAndPositionState();
}

class _SizeAndPositionState extends State<SizeAndPositionPage> {
  final GlobalKey _key = GlobalKey();
  Size? size;
  Size? textSize;
  Size? size3;
  Offset? offset;

  getValue() {
    RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    setState(() {
      size = renderBox?.size;
      offset = renderBox?.localToGlobal(Offset.zero);
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
                style: const TextStyle(fontSize: 20),
              ),
            ),
            GetSize(
              onSize: _getSize,
              child: Container(
                color: Colors.green,
                child: const Text(
                  'Hello World',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            NotificationListener<CustomSizeChangedLayoutNotification>(
              onNotification: (CustomSizeChangedLayoutNotification notification) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {
                    size3 = notification.size;
                  });
                });

                return true;
              },
              child: CustomSizeChangedLayoutNotifier(
                child: Container(
                  width: 300,
                  color: Colors.red,
                  child: Text(
                    'NotificationListener size: $size3',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
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
