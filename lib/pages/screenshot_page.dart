import 'dart:io';
import 'dart:typed_data';

import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ScreenshotPage extends StatefulWidget {
  static const String rName = 'Screenshot';

  @override
  _ScreenshotPageState createState() => _ScreenshotPageState();
}

class _ScreenshotPageState extends State<ScreenshotPage> {
  ScreenShotController controller = ScreenShotController();
  ui.Image image;
  File file;
  ByteData byteData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Screenshot(
                controller: controller,
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: Text('Hello World'),
                ),
              ),
              if (image != null)
                RawImage(
                  image: image,
                ),
              if(byteData != null)
                Image.memory(byteData.buffer.asUint8List()),
              if(file != null)
                Image.file(file, width: 200, height: 200, errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace stackTrace,){
                  Log.info('error: $error, stackTrace: $stackTrace', stackTrace);
                  return Text('Error');
                })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.capture(disableCache: true).then((value) {
            setState(() {
              image = value;
            });
          });

          controller.captureByFile(disableCache: true).then((value) {
            setState(() {
              file = value;
              Log.info('file: $file', StackTrace.current);
            });
          });

          controller.captureByByteData(disableCache: true).then((value) {
            setState(() {
              byteData = value;
              Log.info('byteData: $byteData', StackTrace.current);
            });
          });


        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
