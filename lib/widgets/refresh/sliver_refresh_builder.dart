import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

typedef RefreshWidgetBuilder = Widget Function({
  RefreshState refreshState,
  double pulledExtent,
  double refreshTriggerPullDistance,
  double refreshIndicatorExtent,
});

class SliverRefreshBuilder extends StatefulWidget {
  const SliverRefreshBuilder({
    Key? key,
    this.builder,
    required this.onRefresh,
    required this.focusNotifier,
    this.refreshIndicatorExtent = _defaultRefreshIndicatorExtent,
    this.refreshTriggerPullDistance = _defaultRefreshTriggerPullDistance,
  }) : super(key: key);

  static const double _defaultRefreshTriggerPullDistance = 100.0;
  static const double _defaultRefreshIndicatorExtent = 60.0;

  /// 拖动多少距离触发刷新
  final double refreshTriggerPullDistance;

  /// 刷新widget高度
  final double refreshIndicatorExtent;

  /// 刷新事件
  final RefreshCallback onRefresh;

  /// 滚动状态
  final ValueNotifier<bool> focusNotifier;

  final RefreshWidgetBuilder? builder;

  @override
  _SliverRefreshBuilderState createState() => _SliverRefreshBuilderState();
}

class _SliverRefreshBuilderState extends State<SliverRefreshBuilder> {
  bool hasSliverLayoutExtent = false;
  RefreshState _refreshState = RefreshState.inactive;

  set refreshState(refreshStateValue) {
    if (refreshStateValue == _refreshState) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _refreshState = refreshStateValue;
      });
    });
  }

  ValueNotifier<bool> get focusNotifier => widget.focusNotifier;

  bool get focus => focusNotifier.value;

  RefreshWidgetBuilder? get builder => widget.builder;

  double get refreshTriggerPullDistance => widget.refreshTriggerPullDistance;

  double get refreshIndicatorExtent => widget.refreshIndicatorExtent;

  onBoxExtentChange({required double latestIndicatorBoxExtent, required bool focus}) {
    if (focus == true) {
      if (latestIndicatorBoxExtent >= refreshTriggerPullDistance) {
        refreshState = RefreshState.armed;
      } else if (latestIndicatorBoxExtent < refreshTriggerPullDistance) {
        refreshState = RefreshState.drag;
      }
    } else {
      if (hasSliverLayoutExtent == false &&
          latestIndicatorBoxExtent >= refreshTriggerPullDistance) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          hasSliverLayoutExtent = true;
          refreshState = RefreshState.refresh;
          widget.onRefresh().then((e) {
            setState(() {
              hasSliverLayoutExtent = false;
              refreshState = RefreshState.done;
            });
          });
        });
      }
      if (latestIndicatorBoxExtent == 0) {
        refreshState = RefreshState.inactive;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshWidget(
      hasLayoutExtent: hasSliverLayoutExtent,
      refreshLayoutExtent: widget.refreshIndicatorExtent,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double latestIndicatorBoxExtent = constraints.maxHeight;
          onBoxExtentChange(
              latestIndicatorBoxExtent: latestIndicatorBoxExtent, focus: focus);
          if (latestIndicatorBoxExtent >= 0) {
            if (builder == null) {
              return DefaultRefreshHeader(
                refreshState: _refreshState,
                pulledExtent: latestIndicatorBoxExtent,
                refreshIndicatorExtent: refreshIndicatorExtent,
                refreshTriggerPullDistance: refreshTriggerPullDistance,
              );
            }
            return builder!.call(
              pulledExtent: latestIndicatorBoxExtent,
              refreshIndicatorExtent: refreshIndicatorExtent,
              refreshTriggerPullDistance: refreshTriggerPullDistance,
            );
          }
          return Container();
        },
      ),
    );
  }
}

enum RefreshState {
  ///初始状态
  inactive,

  ///拖动,拖动距离不足以触发onRefresh
  drag,

  ///拖动距离满足触发onRefresh
  armed,

  ///onRefresh 事件正在运行.
  refresh,

  ///刷新完成.
  refreshed,

  ///刷新指示器消失.
  done,
}
