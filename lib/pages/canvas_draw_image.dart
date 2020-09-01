import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CanvasDrawImage extends StatefulWidget {
  static const rName = 'CanvasDrawImage';


  @override
  _CanvasDrawImageState createState() => _CanvasDrawImageState();
}

class _CanvasDrawImageState extends State<CanvasDrawImage> {
  Future<ui.Image> getImage(String asset) async {
    ByteData data = await rootBundle.load(asset);
    Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  Uint8List imageMemory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            imageMemory != null ? Image.memory(imageMemory) : Image.asset('assets/eat_cape_town_sm.jpg'),
            RaisedButton(
              onPressed: () async {
                var pictureRecorder = new PictureRecorder(); // 图片记录仪
                var canvas = new Canvas(pictureRecorder); //canvas接受一个图片记录仪
                var images = await getImage('assets/eat_cape_town_sm.jpg'); // 使用方法获取Unit8List格式的图片
                print(images);
                Paint _linePaint = new Paint()
                  ..color = Colors.blue
                  ..style = PaintingStyle.fill
                  ..isAntiAlias = true
                  ..strokeCap = StrokeCap.round
                  ..strokeWidth = 30.0;

                // 绘制图片
                canvas.drawImage(images, Offset(-150, -150), _linePaint); // 直接画图

                //下面的代码是生成图片的关键代码，以上绘制文字和圆圈的代码可以忽略不计
                var picture = await pictureRecorder.endRecording().toImage(300, 300);//设置生成图片的宽和高
                var pngImageBytes = await picture.toByteData(format: ui.ImageByteFormat.png);
                // var imgBytes = Uint8List.view(pngImageBytes.buffer); //这一行和下面这一行都是生成Uint8List格式的图片（原理还不知道）
                Uint8List pngBytes = pngImageBytes.buffer.asUint8List();
                setState(() {
                  imageMemory = pngBytes;
                });
              },
              child: Text('生成海报'),
            ),
          ],
        ),

      ),
    );
  }
}
