import 'package:demo/util/index.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:image/image.dart' hide Color;

class ImageColorDrawing extends StatefulWidget {
  const ImageColorDrawing({Key? key}) : super(key: key);

  @override
  _ImageColorDrawingState createState() => _ImageColorDrawingState();
}

class _ImageColorDrawingState extends State<ImageColorDrawing> {
  Image? _image;
  List<_Ball> list = [];

  /// 复刻的像素边上.
  double d = 10;

  @override
  void initState() {
    initBalls();
    super.initState();
  }

  /// 初始化小球集合.
  initBalls() async {
    _image = await loadImageFromAssets(Assets.rem02);
    Log.info('image, width: ${_image?.width}, height: ${_image?.height}',
        StackTrace.current);
    if (_image != null) {
      for (int i = 0; i < _image!.width; i++) {
        for (int j = 0; j < _image!.height; j++) {
          _image!.getPixel(i, j);
          var color = Color(_image!.getPixel(i, j));
          list.add(
            _Ball(
              x: i * d + d / 2,
              y: j * d + d / 2,
              r: d / 2,
              color: Color.fromARGB(
                  color.alpha, color.blue, color.green, color.red),
            ),
          );
        }
      }
      setState(() {});
    }
    Log.info('balls: $list', StackTrace.current);
  }

  /// 从Assets加载图片资源
  Future<Image?> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    return decodeImage(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: _PaperPainter(list),
      ),
    );
  }
}

class _PaperPainter extends CustomPainter {
  List<_Ball> list;

  _PaperPainter(this.list);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    for (var ball in list) {
      canvas.drawCircle(
        Offset(ball.x, ball.y),
        ball.r,
        paint..color = ball.color,
      );
    }
  }

  @override
  bool shouldRepaint(_PaperPainter painter) => true;
}

class _Ball {
  /// x坐标
  double x;

  /// y坐标
  double y;

  /// 颜色
  Color color;

  /// 半径
  double r;

  _Ball({
    required this.x,
    required this.y,
    required this.color,
    required this.r,
  });

  @override
  String toString() {
    return '_Ball{x: $x, y: $y, color: $color, r: $r}';
  }
}
