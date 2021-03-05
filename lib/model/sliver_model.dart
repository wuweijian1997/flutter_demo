class SliverModel {
  double overlap;
  double scrollOffset;

  SliverModel({required this.overlap, required this.scrollOffset});

  @override
  String toString() {
    return 'overlap: $overlap \nscrollOffset: $scrollOffset';
  }
}
