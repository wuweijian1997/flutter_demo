import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ColorFragments extends StatefulWidget {
  final Widget child;
  final String tag;

  ColorFragments({Key key, this.child, this.tag}) : super(key: key);

  @override
  _ColorFragmentsState createState() => _ColorFragmentsState();
}

class _ColorFragmentsState extends State<ColorFragments>
    with SingleTickerProviderStateMixin {
  Size imageSize;
  ByteData byteData;
  GlobalObjectKey globalKey;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    globalKey = GlobalObjectKey(widget.tag);
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
  }

  void onTap() {
    if (byteData == null || imageSize == null) {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      boundary.toImage().then((image) {
        imageSize = Size(image.width.toDouble(), image.height.toDouble());
        image.toByteData().then((data) {
          byteData = data;
          controller.forward(from: 0);
        });
      });
    } else {
      controller.forward(from: 0);
    }
  }

  @override
  void didUpdateWidget(ColorFragments oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tag != oldWidget.tag) {
      byteData = null;
      imageSize = null;
      globalKey = GlobalObjectKey(widget.tag);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return _FragmentsRenderObjectWidget(
              key: globalKey,
              child: widget.child,
              byteData: byteData,
              imageSize: imageSize,
              progress: controller.value,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _FragmentsRenderObjectWidget extends RepaintBoundary {
  final ByteData byteData;
  final Size imageSize;
  final double progress;
  final Rect bound;

  _FragmentsRenderObjectWidget({
    Key key,
    Widget child,
    this.bound,
    this.byteData,
    this.progress,
    this.imageSize,
  }) : super(key: key, child: child);

  @override
  RenderRepaintBoundary createRenderObject(BuildContext context) {
    return _FragmentsRenderObject(
        byteData: byteData, imageSize: imageSize, bound: bound);
  }

  @override
  void updateRenderObject(
      BuildContext context, _FragmentsRenderObject renderObject) {
    renderObject
      ..progress = progress
      ..byteData = byteData
      ..imageSize = imageSize;
  }
}

class _FragmentsRenderObject extends RenderRepaintBoundary {
  ByteData _byteData;
  Size _imageSize;
  double _progress;
  List<_Particle> particles;
  Rect _bound;

  _FragmentsRenderObject({
    bound,
    byteData,
    imageSize,
    RenderBox child,
  })  : _bound = bound,
        _byteData = byteData,
        _imageSize = imageSize,
        super(child: child);

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_byteData != null &&
        _imageSize != null &&
        _progress != 0 &&
        _progress != null &&
        _progress != 1) {
      if (particles == null) {
        if (_bound == null) {
          bound = Rect.fromLTWH(0, 0, size.width, size.height * 2);
        }
        particles = initParticleList(_bound, _byteData, _imageSize);
      }
      draw(context.canvas, particles, _progress);
    } else {
      if (child != null) {
        context.paintChild(child, offset);
      }
    }
  }

  bool draw(Canvas canvas, List<_Particle> particles, double progress) {
    Paint paint = Paint();
    for (int i = 0; i < particles.length; i++) {
      _Particle particle = particles[i];
      particle.advance(progress);
      if (particle.alpha > 0) {
        paint.color = particle.color
            .withAlpha((particle.color.alpha * particle.alpha).toInt());
        canvas.drawCircle(
            Offset(particle.cx, particle.cy), particle.radius, paint);
      }
    }
    return true;
  }

  set bound(Rect value) {
    if (value == _bound) return;
    _bound = value;
    markNeedsPaint();
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

  set byteData(ByteData value) {
    if (value == _byteData) return;
    _byteData = value;
    markNeedsPaint();
  }
}

List<_Particle> initParticleList(
    Rect bound, ByteData byteData, Size imageSize) {
  int partLen = 15;
  List<_Particle> particles = List(partLen * partLen);
  Random random = Random(DateTime.now().millisecondsSinceEpoch);
  int w = imageSize.width ~/ (partLen + 2);
  int h = imageSize.height ~/ (partLen + 2);
  for (int i = 0; i < partLen; i++) {
    for (int j = 0; j < partLen; j++) {
      particles[(i * partLen) + j] = generateParticle(
          getColorByPixel(byteData, imageSize,
              Offset((j + 1) * w.toDouble(), (i + 1) * h.toDouble())),
          random,
          bound);
    }
  }
  return particles;
}

Color getColorByPixel(ByteData byteData, Size size, Offset pixel) {
  //rawRgba
  assert(byteData.lengthInBytes == size.width * size.height * 4);
  assert(pixel.dx < size.width && pixel.dy < size.height);
  int index = ((pixel.dy * size.width + pixel.dx) * 4).toInt();
  int r = byteData.getUint8(index);
  int g = byteData.getUint8(index + 1);
  int b = byteData.getUint8(index + 2);
  int a = byteData.getUint8(index + 3);
  return Color.fromARGB(a, r, g, b);
}

_Particle generateParticle(Color color, Random random, Rect bound) {
  _Particle particle = _Particle();
  particle.color = color;
  particle.radius = V;
  if (random.nextDouble() < 0.2) {
    particle.baseRadius = V + ((X - V) * random.nextDouble());
  } else {
    particle.baseRadius = W + ((V - W) * random.nextDouble());
  }
  double nextDouble = random.nextDouble();
  particle.top = bound.height * ((0.18 * random.nextDouble()) + 0.2);
  particle.top = nextDouble < 0.2
      ? particle.top
      : particle.top + ((particle.top * 0.2) * random.nextDouble());
  particle.bottom = (bound.height * (random.nextDouble() - 0.5)) * 1.8;
  double f = nextDouble < 0.2
      ? particle.bottom
      : nextDouble < 0.8 ? particle.bottom * 0.6 : particle.bottom * 0.3;
  particle.bottom = f;
  particle.mag = 4.0 * particle.top / particle.bottom;
  particle.neg = (-particle.mag) / particle.bottom;
  f = bound.center.dx + (Y * (random.nextDouble() - 0.5));
  particle.baseCx = f;
  particle.cx = f;
  f = bound.center.dy + (Y * (random.nextDouble() - 0.5));
  particle.baseCy = f;
  particle.cy = f;
  particle.life = END_VALUE / 10 * random.nextDouble();
  particle.overflow = 0.4 * random.nextDouble();
  particle.alpha = 1;
  return particle;
}

const double END_VALUE = 1.4;
const double V = 10;
const double X = 5;
const double Y = 20;
const double W = 1;

class _Particle {
  double alpha;
  Color color;
  double cx;
  double cy;
  double radius;
  double baseCx;
  double baseCy;
  double baseRadius;
  double top;
  double bottom;
  double mag;
  double neg;
  double life;
  double overflow;

  void advance(double factor) {
    double f = 0;
    double normalization = factor / END_VALUE;
    if (normalization < life || normalization > 1 - overflow) {
      alpha = 0;
      return;
    }
    normalization = (normalization - life) / (1 - life - overflow);
    double f2 = normalization * END_VALUE;
    if (normalization >= 0.7) {
      f = (normalization - 0.7) / 0.3;
    }
    alpha = 1 - f;
    f = bottom * f2;
    cx = baseCx + f;
    cy = (baseCy - this.neg * pow(f, 2.0)) - f * mag;
    radius = V + (baseRadius - V) * f2;
  }
}
