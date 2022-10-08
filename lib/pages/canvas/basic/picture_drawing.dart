import 'dart:math';

import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class PictureDrawing extends StatefulWidget {
  const PictureDrawing({Key? key}) : super(key: key);

  @override
  _PictureDrawingState createState() => _PictureDrawingState();
}

class _PictureDrawingState extends State<PictureDrawing> {
  var list = <ListPageModel>[];
  ui.Image? image;
  final List<Sprite> allSprites = [];

  @override
  void initState() {
    super.initState();
    list = [
      ListPageModel(title: "基础图片绘制", page: BasicCustomPaint(drawBasicPicture)),
      ListPageModel(title: "图片域绘制", page: BasicCustomPaint(drawRectImage)),
      ListPageModel(title: "点9图绘制", page: BasicCustomPaint(drawNineImage)),
      ListPageModel(title: "绘制图集", page: BasicCustomPaint(drawAtlas)),
    ];
    loadImage();
  }

  loadImage() async {
    image = await loadImageFromAssets(Assets.rem);
    setState(() {});
  }

  //读取 assets 中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    Uint8List bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
  }

  /// 基础图片绘制
  drawBasicPicture(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5
      ..color = Colors.blue;
    canvas.translate(size.width / 2, size.height / 2);
    if (image != null) {
      canvas.drawImage(
        image!,
        Offset(-image!.width / 2, -image!.height / 2),
        paint,
      );
    }
  }

  ///图片域绘制
  ///src 表示从资源图片 image 上抠出一块矩形域，所以原点是图片的左上角。
  // dst 表示将抠出的图片填充到画布的哪个矩形域中，所以原点是画布原点。
  drawRectImage(Canvas canvas, Size size) {
    Paint paint = Paint();
    canvas.translate(size.width / 2, size.height / 2);
    if (image != null) {
      canvas.drawImageRect(
        image!,
        Rect.fromCenter(
            center: Offset(image!.width / 2, image!.height / 2),
            width: 100,
            height: 100),
        const Rect.fromLTRB(0, 0, 100, 100).translate(100, 0),
        paint,
      );

      canvas.drawImageRect(
        image!,
        Rect.fromCenter(
            center: Offset(image!.width / 2, image!.height / 2 - 60),
            width: 100,
            height: 100),
        const Rect.fromLTRB(0, 0, 100, 100).translate(-200, -100),
        paint,
      );

      canvas.drawImageRect(
        image!,
        Rect.fromCenter(
            center: Offset(image!.width / 2 + 60, image!.height / 2),
            width: 100,
            height: 100),
        const Rect.fromLTRB(0, 0, 100, 100).translate(-200, 50),
        paint,
      );
    }
  }

  /// 绘制.9图
  /// center 表示从资源图片image上一块可缩放的矩形域，所以原点是图片的左上角。
  // dst 表示将抠出的图片填充到画布的哪个矩形域中，所以原点是画布原点。
  drawNineImage(Canvas canvas, Size size) {
    Paint paint = Paint();
    canvas.translate(size.width / 2, size.height / 2);
    if(image != null) {
      canvas.drawImageNine(
        image!,
        Rect.fromCenter(
            center: Offset(image!.width / 2, image!.height / 2),
            width: 100,
            height: 100),
        Rect.fromCenter(center: Offset.zero, width: 300, height: 300),
        paint,
      );
    }
  }

  /// 绘制图集
  drawAtlas(Canvas canvas, Size size) {
    allSprites.clear();
    if (image == null) return;
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint();

    /// 添加一个雪碧图
    allSprites.add(Sprite(
      position: const Rect.fromLTWH(0, 325, 200, 200),
      offset: const Offset(0, 0),
      alpha: 255,
      rotation: pi / 4,
    ));

    /// 通过allSprites创建RSTransform集合
    final List<RSTransform> transforms = allSprites
        .map((sprite) => RSTransform.fromComponents(
              rotation: sprite.rotation,
              scale: 1,
              anchorX: 100,
              anchorY: 100,
              translateX: sprite.offset.dx,
              translateY: sprite.offset.dy,
            ))
        .toList();

    /// 通过allSprites创建 Rect 集合
    final List<Rect> rects =
        allSprites.map((sprite) => sprite.position).toList();
    if(image != null) {
      canvas.drawAtlas(image!, transforms, rects, null, null, null, paint);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
