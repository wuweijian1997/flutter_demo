class SliverModel {
  double overlap;
  double scrollOffset;

  SliverModel({this.overlap, this.scrollOffset});

  @override
  String toString() {
    return 'overlap: $overlap \nscrollOffset: $scrollOffset';
  }
}
