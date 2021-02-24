# 画布绘制基础
## 画布的变换和状态
### 平移变换
```aidl
@override
void paint(Canvas canvas, Size size) {
  var paint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.blue;
  // 画布起点移到屏幕中心
  canvas.translate(size.width / 2, size.height / 2);
  canvas.drawCircle(Offset(0, 0), 50, paint);
  canvas.drawLine(
      Offset(20, 20),
      Offset(50, 50),
      paint
        ..color = Colors.red
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke);
}
```
### 缩放变换
```aidl
void _drawBottomRight(Canvas canvas, Size size) {
  canvas.save();
  for (int i = 0; i < size.height / 2 / step; i++) {
    canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
    canvas.translate(0, step);
  }
  canvas.restore();
  
  canvas.save();
  for (int i = 0; i < size.width / 2 / step; i++) {
    canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPint);
    canvas.translate(step , 0);
  }
  canvas.restore();
}

void _drawGrid(Canvas canvas, Size size) {
    _drawBottomRight(canvas, size);
    canvas.save();
    canvas.scale(1, -1);//沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1);//沿y轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1);//沿原点镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
  }
```
### 旋转变换
```aidl
void _drawDot(Canvas canvas, Paint paint) {
  final int count = 12;
  paint
    ..color = Colors.orangeAccent
    ..style = PaintingStyle.stroke;
  canvas.save();
  for (int i = 0; i < count; i++) {
    var step = 2 * pi / count;
    canvas.drawLine(Offset(80, 0), Offset(100, 0), paint);
    canvas.rotate(step);
  }
  canvas.restore();
}
```