import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PictureFragments extends StatefulWidget {
  final Widget child;

  /// Horizontal quantity
  final int rowLength;

  // Vertical quantity
  final int columnLength;

  final FragmentsController fragmentsController;

  PictureFragments({
    Key key,
    this.child,
    this.rowLength,
    this.columnLength,
    @required this.fragmentsController,
  }) : super(key: key);

  @override
  _PictureFragmentsState createState() => _PictureFragmentsState();
}

class _PictureFragmentsState extends State<PictureFragments>
    with SingleTickerProviderStateMixin {
  FragmentsController _fragmentsController;

  int get rowLength => widget.rowLength;

  int get columnLength => widget.columnLength;

  @override
  void initState() {
    super.initState();
    _fragmentsController = widget.fragmentsController;
    assert(_fragmentsController != null);
    if (_fragmentsController.animationController == null) {
      _fragmentsController.animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      );
    }
    _fragmentsController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _fragmentsController.animationController,
        builder: (context, child) {
          return _FragmentsRenderObjectWidget(
            key: _fragmentsController.globalKey,
            child: widget.child,
            image: _fragmentsController.image,
            imageSize: _fragmentsController.imageSize,
            progress: _fragmentsController.value,
            rowLength: rowLength,
            columnLength: columnLength,
          );
        },
      ),
    );
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
        _progress != null) {
      if (fragments == null) {
        fragments = initFragments(
          size: _imageSize,
        );
      }
      draw(
        canvas: context.canvas,
        fragments: fragments,
        paintImage: _image,
        columnLength: _columnLength,
        rowLength: _rowLength,
        progress: _progress,
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

  void draw({
    Canvas canvas,
    List<List<Rect>> fragments,
    ui.Image paintImage,
    double progress,
    int rowLength,
    int columnLength,
  }) {
    Paint paint = Paint();
    int rowLength = fragments.length;
    double transition = (rowLength + columnLength) / (rowLength * columnLength);
    transition = min(transition, .1);
    for (int i = 0; i < rowLength; i++) {
      for (int j = 0; j < columnLength; j++) {
        double opacity;
        double currentProgress =
            ((i + 1) / rowLength) * ((j + 1) / columnLength);

        if (currentProgress <= progress) {
          opacity = 0;
        } else if (currentProgress - transition < progress) {
          opacity = .8;
        } else if (currentProgress - transition / 2 < progress) {
          opacity = .9;
        } else {
          opacity = 1;
        }
        paint.color = Colors.white.withOpacity(opacity);
        if (opacity > 0) {
          canvas.drawImageRect(
              paintImage, fragments[i][j], fragments[i][j], paint);
        }
      }
    }
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

class FragmentsController extends ChangeNotifier {
  AnimationController animationController;
  ui.Image _image;
  GlobalKey _globalKey;
  Size _imageSize;

  FragmentsController({this.animationController}) {
    _globalKey = GlobalKey();
  }

  double get value => animationController?.value;

  void start({bool disableCache = false}) {
    if (disableCache == false && image != null && imageSize != null) {
      animationController.forward(from: 0);
      return;
    }
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    boundary.toImage().then((value) {
      _imageSize = Size(value.width.toDouble(), value.height.toDouble());
      _image = value;
      animationController.forward(from: 0);
    });
  }

  ui.Image get image => _image;

  Size get imageSize => _imageSize;

  GlobalKey get globalKey => _globalKey;

  @override
  void dispose() {
    animationController?.dispose();
    _image = null;
    _imageSize = null;
    _globalKey = null;
    super.dispose();
  }
}
