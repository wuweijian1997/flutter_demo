import 'dart:math';
import 'package:flutter/material.dart';

class CustomFlexibleSpaceBar extends StatefulWidget {

  /// Creates a flexible space bar.
  const CustomFlexibleSpaceBar({
    Key? key,
    this.title,
    this.background,
    this.centerTitle,
    this.titlePadding,
    this.collapseMode = CollapseMode.parallax,
    this.stretchModes = const <StretchMode>[StretchMode.zoomBackground],
  }) : super(key: key);

  /// The primary contents of the flexible space bar when expanded.
  final Widget? title;

  /// Shown behind the [title] when expanded.
  final Widget? background;

  /// Whether the title should be centered.
  final bool? centerTitle;

  /// Collapse effect while scrolling.
  final CollapseMode collapseMode;

  /// Stretch effect while over-scrolling,
  final List<StretchMode> stretchModes;

  /// Defines how far the [title] is inset from either the widget's
  /// bottom-left or its center.
  final EdgeInsetsGeometry? titlePadding;

  @override
  _CustomFlexibleSpaceBarState createState() => _CustomFlexibleSpaceBarState();
}

class _CustomFlexibleSpaceBarState extends State<CustomFlexibleSpaceBar> {
  bool _getEffectiveCenterTitle(ThemeData theme) {
    if (widget.centerTitle != null) {
      return widget.centerTitle!;
    }
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
    }
  }

  Alignment _getTitleAlignment(bool effectiveCenterTitle) {
    if (effectiveCenterTitle) {
      return Alignment.bottomCenter;
    }
    final TextDirection textDirection = Directionality.of(context);
    switch (textDirection) {
      case TextDirection.rtl:
        return Alignment.bottomRight;
      case TextDirection.ltr:
        return Alignment.bottomLeft;
    }
  }

  double _getCollapsePadding(double t, FlexibleSpaceBarSettings settings) {
    switch (widget.collapseMode) {
      case CollapseMode.pin:
        return -(settings.maxExtent - settings.currentExtent);
      case CollapseMode.none:
        return 0.0;
      case CollapseMode.parallax:
        final double deltaExtent = settings.maxExtent - settings.minExtent;
        return -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final FlexibleSpaceBarSettings settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;

          final List<Widget> children = <Widget>[];

          final double deltaExtent = settings.maxExtent - settings.minExtent;

          /// 0展开,1,关闭
          /// t = 1  - 移动距离 / 总距离. 剩余移动长度比例
          final double t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent).clamp(0.0, 1.0);

          // background
          if (widget.background != null) {
            final double fadeStart = max(0.0, 1.0 - kToolbarHeight / deltaExtent);
            const double fadeEnd = 1.0;
            final double opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
            if (opacity > 0.0) {
              double height = settings.maxExtent;

              // StretchMode.zoomBackground
              if (widget.stretchModes.contains(StretchMode.zoomBackground) &&
                  constraints.maxHeight > height) {
                height = constraints.maxHeight;
              }

              children.add(Positioned(
                top: _getCollapsePadding(t, settings),
                left: 0.0,
                right: 0.0,
                height: height,
                child: Opacity(
                  opacity: opacity,
                  child: widget.background,
                ),
              ));
            }
          }

          // title
          if (widget.title != null) {
            final ThemeData theme = Theme.of(context);

            Widget title;
            switch (theme.platform) {
              case TargetPlatform.iOS:
              case TargetPlatform.macOS:
                title = widget.title!;
                break;
              case TargetPlatform.android:
              case TargetPlatform.fuchsia:
              case TargetPlatform.linux:
              case TargetPlatform.windows:
                title = Semantics(
                  namesRoute: true,
                  child: widget.title,
                );
                break;
            }

            // StretchMode.fadeTitle
            if (widget.stretchModes.contains(StretchMode.fadeTitle) &&
                constraints.maxHeight > settings.maxExtent) {
              final double stretchOpacity = 1 -
                  (((constraints.maxHeight - settings.maxExtent) / 100).clamp(0.0, 1.0));
              title = Opacity(
                opacity: stretchOpacity,
                child: title,
              );
            }

            final double opacity = settings.toolbarOpacity;
            if (opacity > 0.0) {
              TextStyle titleStyle = theme.primaryTextTheme.titleLarge!;
              titleStyle = titleStyle.copyWith(
                  color: titleStyle.color?.withOpacity(opacity)
              );
              final bool effectiveCenterTitle = _getEffectiveCenterTitle(theme);
              final EdgeInsetsGeometry padding = widget.titlePadding ??
                  EdgeInsetsDirectional.only(
                    start: effectiveCenterTitle ? 0.0 : 72.0,
                    bottom: 16.0,
                  );
              final double scaleValue = Tween<double>(begin: 1.5, end: 1.0).transform(t);
              final Matrix4 scaleTransform = Matrix4.identity()
                ..scale(scaleValue, scaleValue, 1.0);
              final Alignment titleAlignment = _getTitleAlignment(effectiveCenterTitle);
              children.add(Container(
                padding: padding,
                child: Transform(
                  alignment: titleAlignment,
                  transform: scaleTransform,
                  child: Align(
                    alignment: titleAlignment,
                    child: DefaultTextStyle(
                      style: titleStyle,
                      child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return Container(
                              width: constraints.maxWidth / scaleValue,
                              alignment: titleAlignment,
                              child: title,
                            );
                          }
                      ),
                    ),
                  ),
                ),
              ));
            }
          }
          return ClipRect(child: Stack(children: children));
        }
    );
  }
}
