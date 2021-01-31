import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Duration _kDuration = Duration(milliseconds: 300);

class _ActiveItem implements Comparable<_ActiveItem> {
  _ActiveItem.incoming(this.controller, this.itemIndex, {this.animation})
      : removedItemBuilder = null;

  _ActiveItem.outgoing(this.controller, this.itemIndex, this.removedItemBuilder,
      {this.animation});

  _ActiveItem.index(this.itemIndex)
      : controller = null,
        removedItemBuilder = null,
        animation = null;
  final AnimationController controller;
  final Animation animation;
  final AnimatedListRemovedItemBuilder removedItemBuilder;
  int itemIndex;

  @override
  int compareTo(_ActiveItem other) => itemIndex - other.itemIndex;
}

class _ActiveList implements Comparable<_ActiveList> {
  _ActiveList.incoming(this.controller, this.index, this.listLength)
      : removedItemBuilder = null;

  _ActiveList.outgoing(this.controller, this.index, this.listLength, this.removedItemBuilder);

  _ActiveList.index(this.index, this.listLength)
      : controller = null,
        removedItemBuilder = null;
  final AnimationController controller;
  final AnimatedListRemovedItemBuilder removedItemBuilder;
  int index;
  final listLength;

  @override
  int compareTo(_ActiveList other) => (index + listLength) - (other.index + other.listLength);
}



class SimpleAnimatedList extends StatefulWidget {
  final int initialItemCount;
  final AnimatedListItemBuilder itemBuilder;

  SimpleAnimatedList(
      {Key key, this.initialItemCount = 0, @required this.itemBuilder})
      : super(key: key);

  @override
  SimpleAnimatedListState createState() => SimpleAnimatedListState();
}

class SimpleAnimatedListState extends State<SimpleAnimatedList>
    with TickerProviderStateMixin {
  final List<_ActiveItem> _incomingItems = <_ActiveItem>[];
  final List<_ActiveItem> _outgoingItems = <_ActiveItem>[];
  int _itemsCount = 0;

  @override
  void initState() {
    super.initState();
    _itemsCount = widget.initialItemCount;
  }

  _ActiveItem _removeActiveItemAt(List<_ActiveItem> items, int itemIndex) {
    final int i = binarySearch(items, _ActiveItem.index(itemIndex));
    return i == -1 ? null : items.removeAt(i);
  }

  _ActiveItem _activityItemAt(List<_ActiveItem> items, int itemIndex) {
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

  void insertItem(int index, {Duration duration = _kDuration}) {
    final int itemIndex = _indexToItemIndex(index);
    for (final _ActiveItem item in _incomingItems) {
      /// 如果 插入数组中的元素下标大于等于当前插入的位置,则原数组中的元素下标加一.
      /// 例如:当前正在插入3位置的,这时又在3位置插入了一个元素,则原先3位置插入的元素下标加一为4.
      if (item.itemIndex >= itemIndex) item.itemIndex += 1;
    }
    /// 如果 正在移除的数组中的元素下标大于等于当前插入的位置,则原数组中的元素下标加一.
    /// 例如:当前正在移除3位置的元素,这时在2位置插入了一个元素,则原先正在3位置移除的元素下标加一为4
    for (final _ActiveItem item in _outgoingItems) {
      if (item.itemIndex >= itemIndex) item.itemIndex += 1;
    }
    final AnimationController controller = AnimationController(
      duration: duration,
      vsync: this,
    );
    final _ActiveItem incomingItem =
        _ActiveItem.incoming(controller, itemIndex);
    setState(() {
      _incomingItems
        ..add(incomingItem)
        ..sort();
      _itemsCount += 1;
    });

    controller.forward().then<void>((value) {
      _removeActiveItemAt(_incomingItems, incomingItem.itemIndex)
          .controller
          .dispose();
    });
  }

  void insertList(int index, int listLength, {Duration duration = _kDuration}) {
    final int itemIndex = _indexToItemIndex(index);
    for (final _ActiveItem item in _incomingItems) {
      if (item.itemIndex >= itemIndex) item.itemIndex += listLength;
    }
    for (final _ActiveItem item in _outgoingItems) {
      if (item.itemIndex >= itemIndex) item.itemIndex += listLength;
    }
    final AnimationController controller = AnimationController(
      duration: duration,
      vsync: this,
    );
    List<_ActiveItem> incomingList = [];
    for (int i = itemIndex; i < listLength; i++) {
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve:
              Interval((1 / listLength) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      final _ActiveItem incomingItem =
          _ActiveItem.incoming(controller, itemIndex, animation: animation);
      incomingList.add(incomingItem);
    }

    setState(() {
      _incomingItems
        ..addAll(incomingList)
        ..sort();
      _itemsCount += listLength;
    });

    controller.forward().then<void>((value) {
      _removeActiveItemAt(_incomingItems, incomingItem.itemIndex)
          .controller
          .dispose();
    });
  }

  void removeItem(
    int index,
    AnimatedListRemovedItemBuilder builder, {
    Duration duration = _kDuration,
  }) {
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

    controller.reverse().then<void>((value) {
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [SliverList(delegate: _createDelegate())],
    );
  }

  SliverChildDelegate _createDelegate() {
    return SliverChildBuilderDelegate(_itemBuilder, childCount: _itemsCount);
  }

  Widget _itemBuilder(BuildContext context, int itemIndex) {
    final _ActiveItem outgoingItem = _activityItemAt(_outgoingItems, itemIndex);
    if (outgoingItem != null) {
      return outgoingItem.removedItemBuilder(
          context, outgoingItem.controller.view);
    }

    final _ActiveItem incomingItem = _activityItemAt(_incomingItems, itemIndex);
    final Animation<double> animation =
        incomingItem?.controller?.view ?? kAlwaysCompleteAnimation;
    return widget.itemBuilder(
      context,
      _itemIndexToIndex(itemIndex),
      animation,
    );
  }

  @override
  void dispose() {
    for (final _ActiveItem item in _incomingItems.followedBy(_outgoingItems)) {
      item.controller.dispose();
    }
    super.dispose();
  }
}
