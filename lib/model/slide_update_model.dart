enum UpdateType {
  dragging,
  doneDrag,
  animating,
  doneAnimated,
}

enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

class SlideUpdate {
  final UpdateType updateType;
  final SlideDirection direction;
  final double slidePercent;

  SlideUpdate({this.updateType, this.direction, this.slidePercent});
}