import 'dart:math';
import 'dart:ui' as ui;

import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PictureFragments extends StatefulWidget {
  final Widget child;

  /// Horizontal quantity
  final int rowLength;

  // Vertical quantity
  final int columnLength;

  final FragmentsController fragmentsController;

  final Offset startingPoint;

  PictureFragments({
    Key key,
    this.child,
    this.rowLength,
    this.columnLength,
    this.startingPoint = Offset.zero,
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

  Offset get startingPoint => widget.startingPoint;

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
            rowLength: rowLength,
            columnLength: columnLength,
            startingPoint: startingPoint,
            image: _fragmentsController.image,
            progress: _fragmentsController.value,
            imageSize: _fragmentsController.imageSize,
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
  final Offset startingPoint;

  _FragmentsRenderObjectWidget({
    Key key,
    Widget child,
    this.image,
    this.progress,
    this.imageSize,
    this.rowLength,
    this.columnLength,
    this.startingPoint,
  }) : super(key: key, child: child);

  @override
  RenderRepaintBoundary createRenderObject(BuildContext context) {
    return _FragmentsRenderObject(
      image: image,
      imageSize: imageSize,
      columnLength: columnLength,
      rowLength: rowLength,
      startingPoint: startingPoint,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _FragmentsRenderObject renderObject) {
    renderObject
      ..image = image
      ..progress = progress
      ..rowLength = rowLength
      ..columnLength = columnLength
      ..imageSize = imageSize
      ..startingPoint = startingPoint;
  }
}

class _FragmentsRenderObject extends RenderRepaintBoundary {
  ui.Image _image;
  Size _imageSize;
  double _progress;
  List<List<Rect>> fragments;
  int _rowLength;
  int _columnLength;
  Offset _startingPoint;
  int _startingPointX;
  int _startingPointY;

  _FragmentsRenderObject({
    image,
    imageSize,
    RenderBox child,
    int rowLength,
    int columnLength,
    Offset startingPoint,
  })  : _image = image,
        _imageSize = imageSize,
        _rowLength = rowLength,
        _columnLength = columnLength,
        _startingPoint = startingPoint,
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
          rowLength: _rowLength,
          columnLength: _columnLength,
          startingPoint: _startingPoint,
        );
      }
      draw(
        canvas: context.canvas,
        fragments: fragments,
        paintImage: _image,
        columnLength: _columnLength,
        rowLength: _rowLength,
        progress: _progress,
        startingPointX: _startingPointX,
        startingPointY: _startingPointY,
      );
    } else {
      if (child != null) {
        context.paintChild(child, offset);
      }
    }
  }

  List<List<Rect>> initFragments({
    Size size,
    int rowLength,
    int columnLength,
    Offset startingPoint = Offset.zero,
  }) {
    assert(startingPoint != null);
    assert(rowLength != 0 && columnLength != 0);
    ///todo 这里每次点击位置不同都需要重新计算
    double fragmentsWidth = size.width / rowLength;
    _startingPointX = ((startingPoint.dx ~/ fragmentsWidth) - 1).clamp(0, rowLength -1);
    double fragmentsHeight = size.height / columnLength;
    _startingPointY = ((startingPoint.dy ~/ fragmentsHeight) - 1).clamp(0, columnLength -1);

    List<List<Rect>> list = List(rowLength);
    for (int i = 0; i < rowLength; i++) {
      for (int j = 0; j < columnLength; j++) {
        if (list[i] == null) {
          list[i] = List(columnLength);
        }
        list[i][j] = Rect.fromLTWH(fragmentsWidth * i, fragmentsHeight * j, fragmentsWidth, fragmentsHeight);
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
    int startingPointX = 0,
    int startingPointY = 0,
  }) {
    Paint paint = Paint();
    double transition = (rowLength + columnLength) / (rowLength * columnLength);
    transition = min(transition, .1);
    double maxDistance = calculateMaxDistance(rowLength: rowLength, columnLength: columnLength, startingPointX: startingPointX, startingPointY: startingPointY);
    for (int i = 0; i < rowLength; i++) {
      for (int j = 0; j < columnLength; j++) {
        double opacity;
        /*double currentProgress =
            ((i + 1) / rowLength) * ((j + 1) / columnLength);*/
        double currentProgress = calculateFragmentsProgress(
          x: i,
          y: j,
          startingPointY: startingPointY,
          startingPointX: startingPointX,
          maxDistance: maxDistance,
        );

        if (currentProgress <= progress) {
          opacity = 0;
        } else if (currentProgress - transition < progress) {
          opacity = .8;
        } else if (currentProgress - transition / 2 < progress) {
          opacity = .9;
        } else {
          opacity = 1;
        }
        if (opacity > 0) {
          paint.color = Colors.white.withOpacity(opacity);
          canvas.drawImageRect(
              paintImage, fragments[i][j], fragments[i][j], paint);
        }
      }
    }
  }

  double calculateMaxDistance({
    int rowLength,
    int columnLength,
    int startingPointX = 0,
    int startingPointY = 0,
}) {
    int maxHorizontalDistance = max(startingPointX, ((rowLength - 1) - startingPointX).abs());
    int maxVerticalDistance= max(startingPointY, ((columnLength - 1) - startingPointY).abs());
    return sqrt(maxHorizontalDistance * maxHorizontalDistance + maxVerticalDistance * maxVerticalDistance);
  }

  double calculateFragmentsProgress({
    int x,
    int y,
    int startingPointX,
    int startingPointY,
    double maxDistance,
  }) {
    double distance = sqrt((x - startingPointX) * (x - startingPointX) + (y - startingPointY) * (y - startingPointY));
    if(distance > maxDistance) {
      Log.info('x: $x, y: $y, startingPointX: $startingPointX, startingPointY: $startingPointY, ${distance / maxDistance}', StackTrace.current);
    }
    return (distance / maxDistance).clamp(.0, 1.0);
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
    markNeedsPaint();
  }

  set rowLength(int value) {
    if (value == _rowLength) return;
    _rowLength = value;
    markNeedsPaint();
  }

  set startingPoint(Offset value) {
    if (value == _startingPoint) return;
    _startingPoint = value;
    markNeedsPaint();
  }
}

class FragmentsController {
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

  void dispose() {
    animationController?.dispose();
    _image = null;
    _imageSize = null;
    _globalKey = null;
  }
}
