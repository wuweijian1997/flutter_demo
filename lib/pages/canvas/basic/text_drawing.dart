import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TextDrawing extends StatefulWidget {
  const TextDrawing({Key? key}) : super(key: key);

  @override
  _TextDrawingState createState() => _TextDrawingState();
}

class _TextDrawingState extends State<TextDrawing> {
  var list = <ListPageModel>[];

  @override
  void initState() {
    list = [
      ListPageModel(
          title: "drawParagraph绘制文字",
          page: BasicCustomPaint(drawTextWithParagraph)),
      ListPageModel(
          title: "TextPainter获取文字范围",
          page: BasicCustomPaint(drawTextPaintShowSize)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }

  ///drawParagraph绘制文字
  drawTextWithParagraph(Canvas canvas, Size size) {
    canvas.translate((size.width - 300) / 2, (size.height - 100) / 2);
    drawTextWithParagraphAlign(canvas, TextAlign.left);
    canvas.translate(0, 50);
    drawTextWithParagraphAlign(canvas, TextAlign.center);
    canvas.translate(0, 50);
    drawTextWithParagraphAlign(canvas, TextAlign.right);
  }

  drawTextWithParagraphAlign(Canvas canvas, TextAlign textAlign) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: textAlign,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ));

    builder.pushStyle(ui.TextStyle(
        color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic));
    builder.addText("Hello World");
    ui.Paragraph paragraph = builder.build();
    paragraph.layout(const ui.ParagraphConstraints(width: 300));
    canvas.drawParagraph(paragraph, Offset.zero);
    canvas.drawRect(const Rect.fromLTRB(0, 0, 300, 40),
        Paint()..color = Colors.blue.withOpacity(0.5));
  }

  /// TextPainter获取文字范围
  drawTextPaintShowSize(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    TextPainter textPainter = TextPainter(
        text: const TextSpan(
            text: "Hello World",
            style: TextStyle(fontSize: 40, color: Colors.black)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    ///进行布局
    textPainter.layout();
    Size textSize = textPainter.size;
    Log.info('textSize: $textSize', StackTrace.current);
    textPainter.paint(canvas, Offset(-textSize.width / 2, -textSize.height / 2));
    canvas.drawRect(Rect.fromLTRB(0, 0, textSize.width, textSize.height).translate(-textSize.width / 2, -textSize.height / 2), Paint()..color = Colors.blue.withAlpha(33));

    TextPainter sizeTextPainter = TextPainter(
      text: TextSpan(text: textSize.toString(), style: const TextStyle(fontSize: 30, color: Colors.green)),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr
    );
    sizeTextPainter.layout();
    sizeTextPainter.paint(canvas, const Offset(-100, 100));
  }
}
