import 'dart:ui';

import 'package:demo/util/index.dart';
import 'package:flutter/material.dart' hide Gradient;

/// 短线长
const double _kHeightLevel = 20;

/// 5 线长
const double _kHeightLevel5 = 25;

/// 10 线长
const double _kHeightLevel10 = 30;

/// 左侧偏移
const double _kPrefixOffset = 5;

/// 线顶部偏移
const double _kVerticalOffset = 12;

/// 刻宽度
const double _kStrokeWidth = 2;

/// 刻度间隙
const double _kSpacer = 4;

/// 渐变色
const List<Color> _kRulerColors = [
  Color(0xFF1426FB),
  Color(0xFF6080FB),
  Color(0xFFBEE0FB),
];
const List<double> _kRulerColorStops = [0, 0.2, 0.8];

class RulerChooser extends StatefulWidget {
  final Size size;
  final ValueChanged<double>? onChanged;
  final int min;
  final int max;

  const RulerChooser({
    Key? key,
    this.size = const Size(240, 60),
    this.onChanged,
    this.min = 100,
    this.max = 200,
  }) : super(key: key);

  @override
  _RulerChooserState createState() => _RulerChooserState();
}

class _RulerChooserState extends State<RulerChooser> {
  final ValueNotifier<double> _dx = ValueNotifier(0);
  double dx = 0;

  /// 滑动
  onUpdate(DragUpdateDetails details) {
    dx += details.delta.dx;
    if (dx > 0) {
      dx = 0;
    }
    var limitMax = -(widget.max - widget.min) * (_kSpacer + _kStrokeWidth);
    if (dx < limitMax) {
      dx = limitMax;
    }
    _dx.value = dx;
    double value = widget.min - dx / (_kSpacer + _kStrokeWidth);
    Log.info('value: $value', StackTrace.current);
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanUpdate: onUpdate,
        child: CustomPaint(
          size: widget.size,
          painter: _HandlerPainter(min: widget.min, max: widget.max, dx: _dx),
        ),
      ),
    );
  }
}

class _HandlerPainter extends CustomPainter {
  final Paint _pointPaint = Paint()
        ..color = Colors.purple
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
      _paint = Paint()
        ..strokeWidth = _kStrokeWidth
        ..shader = Gradient.radial(
          Offset.zero,
          25,
          _kRulerColors,
          _kRulerColorStops,
          TileMode.mirror,
        );

  final ValueNotifier<double> dx;
  final int max;
  final int min;

  _HandlerPainter({required this.dx, required this.max, required this.min})
      : super(repaint: dx);

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.clipRect(Offset.zero & size);
    drawArrow(canvas);
    canvas.translate(_kStrokeWidth / 2 + _kPrefixOffset, _kVerticalOffset);
    canvas.translate(dx.value, 0);
    drawRuler(canvas);
  }

  @override
  bool shouldRepaint(_HandlerPainter oldDelegate) =>
      oldDelegate.dx != dx || oldDelegate.min != min || oldDelegate.max != max;

  /// 绘制三角形尖角
  void drawArrow(Canvas canvas) {
    Path path = Path()
      ..moveTo(_kStrokeWidth / 2 + _kPrefixOffset, 3)
      ..relativeLineTo(-3, 0)
      ..relativeLineTo(3, _kPrefixOffset)
      ..relativeLineTo(3, -_kPrefixOffset)
      ..close();
    canvas.drawPath(path, _pointPaint);
  }

  void drawRuler(Canvas canvas) {
    double y = _kHeightLevel;
    for (int i = min; i < max; i++) {
      if (i % 5 == 0 && i % 10 != 0) {
        y = _kHeightLevel5;
      } else if (i % 10 == 0) {
        y = _kHeightLevel10;
        _simpleDrawText(
          canvas,
          i.toString(),
          offset: const Offset(-3, _kHeightLevel10 + 5),
        );
      } else {
        y = _kHeightLevel;
      }
      canvas.drawLine(Offset.zero, Offset(0, y), _paint);
      canvas.translate(_kStrokeWidth + _kSpacer, 0);
    }
  }

  void _simpleDrawText(
    Canvas canvas,
    String string, {
    Offset offset = Offset.zero,
  }) {
    canvas.save();
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: string, style: const TextStyle(fontSize: 12, color: Colors.black)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    ///进行布局
    textPainter.layout();
    Size textSize = textPainter.size;
    canvas.translate(-(textSize.width) / 2 + _kStrokeWidth, 0);
    textPainter.paint(canvas, offset);
    // canvas.drawRect(offset & textSize, Paint()..color = Colors.blue.withAlpha(33));
    canvas.restore();
  }
}
