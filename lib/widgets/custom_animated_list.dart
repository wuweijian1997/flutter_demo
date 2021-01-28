// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 构建AnimatedList 子组件
typedef AnimatedListItemBuilder = Widget Function(
    BuildContext context, int index, Animation<double> animation);

/// 删除的单个子组件
typedef AnimatedListRemovedItemBuilder = Widget Function(
    BuildContext context, Animation<double> animation);

/// 默认插入删除动画时间
const Duration _kDuration = Duration(milliseconds: 300);

// 插入和删除的AnimatedList item。
class _ActiveItem implements Comparable<_ActiveItem> {
  _ActiveItem.incoming(this.controller, this.itemIndex)
      : removedItemBuilder = null;

  _ActiveItem.outgoing(
      this.controller, this.itemIndex, this.removedItemBuilder);

  _ActiveItem.index(this.itemIndex)
      : controller = null,
        removedItemBuilder = null;

  final AnimationController controller;
  final AnimatedListRemovedItemBuilder removedItemBuilder;
  int itemIndex;

  @override
  int compareTo(_ActiveItem other) => itemIndex - other.itemIndex;
}

/// 一个滚动的容器，用于在插入或删除项目时对其进行动画处理。
class CustomAnimatedList extends StatefulWidget {
  /// 一个滚动的容器，用于在插入或删除项目时对其进行动画处理。
  const CustomAnimatedList({
    Key key,
    @required this.itemBuilder,
    this.initialItemCount = 0,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
  }) : super(key: key);

  /// 构建单个组件回调
  final AnimatedListItemBuilder itemBuilder;

  /// 组件数量
  final int initialItemCount;

  /// 滚动 方向
  final Axis scrollDirection;

  /// 是否反向排列
  final bool reverse;

  /// 滚动控制器
  final ScrollController controller;

  /// 这是否是与父级关联的主滚动视图
  final bool primary;

  /// 滚动视图应如何响应用户输入。
  final ScrollPhysics physics;

  /// 中滚动视图的范围是否应该由所查看的内容确定。
  final bool shrinkWrap;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// AnimatedList 的state
  static CustomAnimatedListState of(BuildContext context,
      {bool nullOk = false}) {
    final CustomAnimatedListState result =
        context.findAncestorStateOfType<CustomAnimatedListState>();
    if (nullOk || result != null) return result;
    return null;
  }

  @override
  CustomAnimatedListState createState() => CustomAnimatedListState();
}

/// The state for a scrolling container that animates items when they are
/// inserted or removed.
class CustomAnimatedListState extends State<CustomAnimatedList>
    with TickerProviderStateMixin<CustomAnimatedList> {
  final GlobalKey<CustomSliverAnimatedListState> _sliverAnimatedListKey =
      GlobalKey();

  /// 插入子组件
  void insertItem(int index, {Duration duration = _kDuration}) {
    _sliverAnimatedListKey.currentState.insertItem(index, duration: duration);
  }

  /// 删除子组件
  void removeItem(int index, AnimatedListRemovedItemBuilder builder,
      {Duration duration = _kDuration}) {
    _sliverAnimatedListKey.currentState
        .removeItem(index, builder, duration: duration);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      slivers: <Widget>[
        SliverPadding(
          padding: widget.padding ?? const EdgeInsets.all(0),
          sliver: CustomSliverAnimatedList(
            key: _sliverAnimatedListKey,
            itemBuilder: widget.itemBuilder,
            initialItemCount: widget.initialItemCount,
          ),
        ),
      ],
    );
  }
}

/// SliverAnimatedList
class CustomSliverAnimatedList extends StatefulWidget {
  /// SliverAnimatedList
  const CustomSliverAnimatedList({
    Key key,
    @required this.itemBuilder,
    this.initialItemCount = 0,
  }) : super(key: key);

  /// 子组件构建方法
  final AnimatedListItemBuilder itemBuilder;

  /// 初始子组件数量
  final int initialItemCount;

  @override
  CustomSliverAnimatedListState createState() =>
      CustomSliverAnimatedListState();

  /// 获取CustomSliverAnimatedListState 的状态
  static CustomSliverAnimatedListState of(BuildContext context,
      {bool nullOk = false}) {
    final CustomSliverAnimatedListState result =
        context.findAncestorStateOfType<CustomSliverAnimatedListState>();
    if (nullOk || result != null) return result;
    return null;
  }
}

/// CustomSliverAnimatedListState
class CustomSliverAnimatedListState extends State<CustomSliverAnimatedList>
    with TickerProviderStateMixin {
  final List<_ActiveItem> _incomingItems = <_ActiveItem>[];
  final List<_ActiveItem> _outgoingItems = <_ActiveItem>[];
  int _itemsCount = 0;

  @override
  void initState() {
    super.initState();
    _itemsCount = widget.initialItemCount;
  }

  @override
  void didUpdateWidget(CustomSliverAnimatedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialItemCount != _itemsCount) {
      _itemsCount = widget.initialItemCount;
    }
  }

  @override
  void dispose() {
    for (final _ActiveItem item in _incomingItems.followedBy(_outgoingItems)) {
      item.controller.dispose();
    }
    super.dispose();
  }

  _ActiveItem _removeActiveItemAt(List<_ActiveItem> items, int itemIndex) {
    final int i = binarySearch(items, _ActiveItem.index(itemIndex));
    return i == -1 ? null : items.removeAt(i);
  }

  _ActiveItem _activeItemAt(List<_ActiveItem> items, int itemIndex) {
    final int i = binarySearch(items, _ActiveItem.index(itemIndex));
    return i == -1 ? null : items[i];
  }

  int _indexToItemIndex(int index) {
    int itemIndex = index;
    for (final _ActiveItem item in _outgoingItems) {
      if (item.itemIndex <= itemIndex)
        itemIndex += 1;
      else
        break;
    }
    return itemIndex;
  }

  int _itemIndexToIndex(int itemIndex) {
    int index = itemIndex;
    for (final _ActiveItem item in _outgoingItems) {
      if (item.itemIndex < itemIndex)
        index -= 1;
      else
        break;
    }
    return index;
  }

  SliverChildDelegate _createDelegate() {
    return SliverChildBuilderDelegate(_itemBuilder, childCount: _itemsCount);
  }

  /// 插入组件
  void insertItem(int index, {Duration duration = _kDuration}) {
    final int itemIndex = _indexToItemIndex(index);
    for (final _ActiveItem item in _incomingItems) {
      if (item.itemIndex >= itemIndex) item.itemIndex += 1;
    }
    for (final _ActiveItem item in _outgoingItems) {
      if (item.itemIndex >= itemIndex) item.itemIndex += 1;
    }

    final AnimationController controller = AnimationController(
      duration: duration,
      vsync: this,
    );
    final _ActiveItem incomingItem = _ActiveItem.incoming(
      controller,
      itemIndex,
    );
    setState(() {
      _incomingItems
        ..add(incomingItem)
        ..sort();
      _itemsCount += 1;
    });
    controller.forward().then<void>((_) {
      _removeActiveItemAt(_incomingItems, incomingItem.itemIndex)
          .controller
          .dispose();
    });
  }

  /// 删除组件
  void removeItem(int index, AnimatedListRemovedItemBuilder builder,
      {Duration duration = _kDuration}) {

    final int itemIndex = _indexToItemIndex(index);

    final _ActiveItem incomingItem =
        _removeActiveItemAt(_incomingItems, itemIndex);
    final AnimationController controller = incomingItem?.controller ??
        AnimationController(duration: duration, value: 1.0, vsync: this);
    final _ActiveItem outgoingItem =
        _ActiveItem.outgoing(controller, itemIndex, builder);
    setState(() {
      _outgoingItems
        ..add(outgoingItem)
        ..sort();
    });

    controller.reverse().then<void>((void value) {
      _removeActiveItemAt(_outgoingItems, outgoingItem.itemIndex)
          .controller
          .dispose();

      for (final _ActiveItem item in _incomingItems) {
        if (item.itemIndex > outgoingItem.itemIndex) item.itemIndex -= 1;
      }
      for (final _ActiveItem item in _outgoingItems) {
        if (item.itemIndex > outgoingItem.itemIndex) item.itemIndex -= 1;
      }

      setState(() => _itemsCount -= 1);
    });
  }

  Widget _itemBuilder(BuildContext context, int itemIndex) {
    final _ActiveItem outgoingItem = _activeItemAt(_outgoingItems, itemIndex);
    if (outgoingItem != null) {
      return outgoingItem.removedItemBuilder(
        context,
        outgoingItem.controller.view,
      );
    }

    final _ActiveItem incomingItem = _activeItemAt(_incomingItems, itemIndex);
    final Animation<double> animation =
        incomingItem?.controller?.view ?? kAlwaysCompleteAnimation;
    return widget.itemBuilder(
      context,
      _itemIndexToIndex(itemIndex),
      animation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: _createDelegate(),
    );
  }
}
