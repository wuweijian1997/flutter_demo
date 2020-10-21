import 'package:flutter/material.dart';

class CustomFlexibleSpaceBar extends StatefulWidget {

  /// Creates a flexible space bar.
  const CustomFlexibleSpaceBar({
    Key key,
    this.title,
    this.background,
    this.centerTitle,
    this.titlePadding,
    this.collapseMode = CollapseMode.parallax,
    this.stretchModes = const <StretchMode>[StretchMode.zoomBackground],
  }) : super(key: key);

  /// The primary contents of the flexible space bar when expanded.
  final Widget title;

  /// Shown behind the [title] when expanded.
  final Widget background;

  /// Whether the title should be centered.
  final bool centerTitle;

  /// Collapse effect while scrolling.
  final CollapseMode collapseMode;

  /// Stretch effect while over-scrolling,
  final List<StretchMode> stretchModes;

  /// Defines how far the [title] is inset from either the widget's
  /// bottom-left or its center.
  final EdgeInsetsGeometry titlePadding;

  @override
  _CustomFlexibleSpaceBarState createState() => _CustomFlexibleSpaceBarState();
}

class _CustomFlexibleSpaceBarState extends State<CustomFlexibleSpaceBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
