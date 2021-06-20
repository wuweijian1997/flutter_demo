import 'dart:ui';

import 'package:demo/util/index.dart';
import 'package:demo/widgets/basic_custom_paint.dart';
import 'package:flutter/material.dart';
import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';

/// 路径测量
/// computeMetrics: 获取某点在路径的位置角度,路径长度等.
/// PathMetrics: 路径的测量信息.
class PathMeasurePage extends StatefulWidget {
  @override
  _PathMeasurePageState createState() => _PathMeasurePageState();
}

class _PathMeasurePageState extends State<PathMeasurePage> {
  var list = <ListPageModel>[];

  @override
  void initState() {
    list = [
      ListPageModel(
        title: 'computeMetrics',
        page: BasicCustomPaint(computeMetrics),
      ),
      ListPageModel(
        title: '路径的测量和动画',
        page: ComputeMetricsAnimation(),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }

  /// 路径测量信息
  computeMetrics(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path()
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    path.addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50));

    PathMetrics pms = path.computeMetrics();
    pms.forEach((pm) {
      Log.info(
          "路径长度 - length: ${pm.length}, 路径索引 - contourIndex: ${pm.contourIndex}, 路径闭合 - isClosed: ${pm.isClosed}",
          StackTrace.current);
    });

    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.pink
          ..style = PaintingStyle.stroke);
  }
}

class ComputeMetricsAnimation extends StatefulWidget {
  @override
  _ComputeMetricsAnimationState createState() =>
      _ComputeMetricsAnimationState();
}

class _ComputeMetricsAnimationState extends State<ComputeMetricsAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: MetricsAnimationPainter(progress: _animationController),
      ),
    );
  }
}

class MetricsAnimationPainter extends CustomPainter {
  final Animation<double> progress;

  MetricsAnimationPainter({required this.progress}) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    Path path = Path()
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();
    path.addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50));
    PathMetrics pms = path.computeMetrics();
    pms.forEach((pm) {
      Tangent? tangent = pm.getTangentForOffset(pm.length * progress.value);
      if (tangent != null) {
        canvas.drawCircle(
            tangent.position, 5, Paint()..color = Colors.deepOrange);
      }
    });
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MetricsAnimationPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
