import 'dart:ui' as ui;

import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PictureFragments extends StatefulWidget {
  final Widget child;
  final String tag;
  final int rowLength;
  final int columnLength;

  PictureFragments({
    Key key,
    this.tag,
    this.child,
    this.rowLength,
    this.columnLength,
  }) : super(key: key);

  @override
  _PictureFragmentsState createState() => _PictureFragmentsState();
}

class _PictureFragmentsState extends State<PictureFragments>
    with SingleTickerProviderStateMixin {
  ui.Image image;
  Size imageSize;
  GlobalObjectKey globalKey;
  AnimationController controller;

  int get rowLength => widget.rowLength;

  int get columnLength => widget.columnLength;

  @override
  void initState() {
    super.initState();
    globalKey = GlobalObjectKey(widget.tag);
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  void onTap() {
    if (image == null || imageSize == null) {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      boundary.toImage().then((value) {
        imageSize = Size(value.width.toDouble(), value.height.toDouble());
        image = value;
        controller.forward(from: 0);
      });
    } else {
      controller.forward(from: 0);
    }
  }

  @override
  void didUpdateWidget(PictureFragments oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tag != oldWidget.tag) {
      imageSize = null;
      globalKey = GlobalObjectKey(widget.tag);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return _FragmentsRenderObjectWidget(
              key: globalKey,
              child: widget.child,
              image: image,
              imageSize: imageSize,
              progress: controller.value,
              rowLength: rowLength,
              columnLength: columnLength,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _FragmentsRenderObjectWidget extends RepaintBoundary {
  final ui.Image image;
  final Size imageSize;
  final double progress;
  final int rowLength;
  final int columnLength;

  _FragmentsRenderObjectWidget({
    Key key,
    Widget child,
    this.image,
    this.progress,
    this.imageSize,
    this.rowLength,
    this.columnLength,
  }) : super(key: key, child: child);

  @override
  RenderRepaintBoundary createRenderObject(BuildContext context) {
    return _FragmentsRenderObject(
        image: image,
        imageSize: imageSize,
        columnLength: columnLength,
        rowLength: rowLength);
  }

  @override
  void updateRenderObject(
      BuildContext context, _FragmentsRenderObject renderObject) {
    renderObject
      ..image = image
      ..progress = progress
      ..rowLength = rowLength
      ..columnLength = columnLength
      ..imageSize = imageSize;
  }
}

class _FragmentsRenderObject extends RenderRepaintBoundary {
  ui.Image _image;
  Size _imageSize;
  double _progress;
  List<List<Rect>> fragments;
  int _rowLength;
  int _columnLength;

  _FragmentsRenderObject({
    image,
    imageSize,
    RenderBox child,
    int rowLength,
    int columnLength,
  })  : _image = image,
        _imageSize = imageSize,
        _rowLength = rowLength,
        _columnLength = columnLength,
        super(child: child);

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_image != null &&
        _imageSize != null &&
        _progress != 0 &&
        _progress != null &&
        _progress != 1) {
      if (fragments == null) {
        fragments = initFragments(
          size: _imageSize,
        );
      }
      draw(
        canvas: context.canvas,
        fragments: fragments,
        paintImage: _image,
      );
    } else {
      if (child != null) {
        context.paintChild(child, offset);
      }
    }
  }

  List<List<Rect>> initFragments({
    Size size,
  }) {
    assert(_rowLength != 0 && _columnLength != 0);
    List<List<Rect>> list = List(_rowLength);
    double width = size.width / _rowLength;
    double height = size.height / _columnLength;
    for (int i = 0; i < _rowLength; i++) {
      for (int j = 0; j < _columnLength; j++) {
        if (list[i] == null) {
          list[i] = List(_columnLength);
        }
        list[i][j] = Rect.fromLTWH(width * i, height * j, width, height);
      }
    }
    return list;
  }

  bool draw({
    Canvas canvas,
    List<List<Rect>> fragments,
    ui.Image paintImage,
  }) {
    Paint paint = Paint();
    int rowLength = fragments.length;
    for (int i = 0; i < rowLength; i++) {
      int columnLength = fragments[i].length;
      for (int j = 0; j < columnLength; j++) {
        double progress = _progress;
        double opacity;
        double currentProgress =
            ((i + 1) / rowLength) * ((j + 1) / columnLength);
        double temp = (_rowLength + _columnLength) / (_rowLength * _columnLength);
        if (currentProgress > progress + .1) {
          opacity = 1;
        } else if (currentProgress + temp / 2 > progress) {
          opacity = .6;
        } else if (currentProgress + temp > progress) {
          opacity = .3;
        } else {
          opacity = 0;
        }
        paint.color = Colors.white.withOpacity(opacity);
        if (opacity > 0) {
          canvas.drawImageRect(
              paintImage, fragments[i][j], fragments[i][j], paint);
        }
      }
    }
    return true;
  }

  set progress(double value) {
    if (value == _progress) return;
    _progress = value;
    markNeedsPaint();
  }

  set imageSize(Size value) {
    if (value == _imageSize) return;
    _imageSize = value;
    markNeedsPaint();
  }

  set image(ui.Image value) {
    if (value == _image) return;
    _image = value;
    markNeedsPaint();
  }

  set columnLength(int value) {
    if (value == _columnLength) return;
    _columnLength = value;
  }

  set rowLength(int value) {
    if (value == _rowLength) return;
    _rowLength = value;
  }
}
