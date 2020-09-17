import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/services.dart';

class BasicPage extends StatefulWidget {

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {

  final tabs = [
    const Tab(text: '点',),
    const Tab(text: '线',),
    const Tab(text: '圆', ),
    const Tab(text: '椭圆', ),
    const Tab(text: '圆弧', ),
    const Tab(text: '矩形', ),
    const Tab(text: '路径', ),
    const Tab(text: '颜色', ),
    const Tab(text: '图片&文字', ),
  ];

  ui.Image image;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initImage();
  }

  initImage() async {
    var imageCache = await getImage('./assets/rem.jpg');
    setState(() {
      image = imageCache;
    });
  }

  Future<ui.Image> getImage(String asset) async {
    ByteData data = await rootBundle.load(asset);
    Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs,
          ),
        ),
        body: Container(
          child: TabBarView(
            children: [
              _BasicTabPage(painter: PointCanvasWidget(),),
              _BasicTabPage(painter: LineCanvasWidget(),),
              _BasicTabPage(painter: CircleCanvasWidget(),),
              _BasicTabPage(painter: OvalCanvasWidget(),),
              _BasicTabPage(painter: ArcCanvasWidget(),),
              _BasicTabPage(painter: RectCanvasWidget(),),
              _BasicTabPage(painter: PathCanvasWidget(),),
              _BasicTabPage(painter: ColorCanvasWidget(),),
              _BasicTabPage(painter: ImageCanvasWidget(image: image),),
            ],
          ),
        ),
      ),
    );
  }
}

class _BasicTabPage extends StatelessWidget {
  final CustomPainter painter;

  _BasicTabPage({this.painter});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: painter,
      ),
    );
  }
}