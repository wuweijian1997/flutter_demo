import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class Screenshot extends StatefulWidget {
  final Widget child;
  final CustomScreenShotController controller;

  const Screenshot({Key? key, required this.child, required this.controller}) : super(key: key);

  @override
  _ScreenshotState createState() => _ScreenshotState();
}

class _ScreenshotState extends State<Screenshot> {
  late CustomScreenShotController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  @override
  void didUpdateWidget(Screenshot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      controller = widget.controller;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: controller.key,
      child: widget.child,
    );
  }
}

class CustomScreenShotController {
  late GlobalKey key;
  ui.Image? _uiImage;
  ByteData? _byteData;
  File? _file;

  CustomScreenShotController() {
    key = GlobalKey();
  }

  ///
  Future<ui.Image> capture({
    double pixelRatio = 1.0,
    bool disableCache = false,
  }) {
    if (disableCache == false && _uiImage != null) {
      return Future.value(_uiImage);
    }
    RenderRepaintBoundary boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary;
    return boundary.toImage(pixelRatio: pixelRatio).then((ui.Image value) {
      if (disableCache == false) {
        _uiImage = value;
      }
      return value;
    });
  }

  Future<ByteData?> captureByByteData({
    double pixelRatio = 1.0,
    bool disableCache = false,
  }) async {
    if (disableCache == false && _byteData != null) {
      return Future.value(_byteData);
    }
    ui.Image image = await capture(
      disableCache: disableCache,
      pixelRatio: pixelRatio,
    );
    return image
        .toByteData(format: ui.ImageByteFormat.png)
        .then((ByteData? value) {
      if (disableCache == false) {
        _byteData = value;
      }
      return value;
    });
  }

  Future<File?> captureByFile({
    String path = "",
    double pixelRatio = 1.0,
    bool disableCache = false,
  }) async {
    if (disableCache == false && _file != null) {
      return Future.value(_file);
    }
    ByteData? data = await captureByByteData(
      disableCache: disableCache,
      pixelRatio: pixelRatio,
    );
    if(data == null) {
      return null;
    }
    Uint8List pngBytes = data.buffer.asUint8List();
    if ( path.trim().isEmpty) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      String fileName = DateTime.now().toIso8601String();
      path = '$directory/$fileName.png';
    }
    File imgFile = File(path);
    return imgFile.writeAsBytes(pngBytes).then((File value) {
      if (disableCache == false) {
        _file = value;
      }
      return value;
    });
  }

  dispose() {
    _file = null;
    _uiImage = null;
    _byteData = null;
  }
}
