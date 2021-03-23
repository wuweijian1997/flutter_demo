import 'dart:ui';

import 'package:demo/util/index.dart';
import 'package:demo/widgets/basic_custom_paint.dart';
import 'package:flutter/material.dart';
import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';

/// 路径测量
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
      Log.info("路径长度 - length: ${pm.length}, 路径索引 - contourIndex: ${pm.contourIndex}, 路径闭合 - isClosed: ${pm.isClosed}", StackTrace.current);
    });

    canvas.drawPath(path, Paint()..color = Colors.pink..style = PaintingStyle.stroke);
  }
}
