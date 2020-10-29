// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Signature for the builder callback used by [CustomAnimatedList].
typedef AnimatedListItemBuilder = Widget Function(BuildContext context, int index, Animation<double> animation);

/// Signature for the builder callback used by [CustomAnimatedListState.removeItem].
typedef AnimatedListRemovedItemBuilder = Widget Function(BuildContext context, Animation<double> animation);

// The default insert/remove animation duration.
const Duration _kDuration = Duration(milliseconds: 300);

// Incoming and outgoing AnimatedList items.
class _ActiveItem implements Comparable<_ActiveItem> {
  _ActiveItem.incoming(this.controller, this.itemIndex) : removedItemBuilder = null;
  _ActiveItem.outgoing(this.controller, this.itemIndex, this.removedItemBuilder);
  _ActiveItem.index(this.itemIndex)
      : controller = null,
        removedItemBuilder = null;

  final AnimationController controller;
  final AnimatedListRemovedItemBuilder removedItemBuilder;
  int itemIndex;

  @override
  int compareTo(_ActiveItem other) => itemIndex - other.itemIndex;
}

/// A scrolling container that animates items when they are inserted or removed.
///
/// This widget's [CustomAnimatedListState] can be used to dynamically insert or
/// remove items. To refer to the [CustomAnimatedListState] either provide a
/// [GlobalKey] or use the static [of] method from an item's input callback.
///
/// This widget is similar to one created by [ListView.builder].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=ZtfItHwFlZ8}
///
/// {@tool dartpad --template=freeform}
/// This sample application uses an [CustomAnimatedList] to create an effect when
/// items are removed or added to the list.
///
/// ```dart imports
/// import 'package:flutter/foundation.dart';
/// import 'package:flutter/material.dart';
/// ```
///
/// ```dart
/// class AnimatedListSample extends StatefulWidget {
///   @override
///   _AnimatedListSampleState createState() => _AnimatedListSampleState();
/// }
///
/// class _AnimatedListSampleState extends State<AnimatedListSample> {
///   final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
///   ListModel<int> _list;
///   int _selectedItem;
///   int _nextItem; // The next item inserted when the user presses the '+' button.
///
///   @override
///   void initState() {
///     super.initState();
///     _list = ListModel<int>(
///       listKey: _listKey,
///       initialItems: <int>[0, 1, 2],
///       removedItemBuilder: _buildRemovedItem,
///     );
///     _nextItem = 3;
///   }
///
///   // Used to build list items that haven't been removed.
///   Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
///     return CardItem(
///       animation: animation,
///       item: _list[index],
///       selected: _selectedItem == _list[index],
///       onTap: () {
///         setState(() {
///           _selectedItem = _selectedItem == _list[index] ? null : _list[index];
///         });
///       },
///     );
///   }
///
///   // Used to build an item after it has been removed from the list. This
///   // method is needed because a removed item remains visible until its
///   // animation has completed (even though it's gone as far this ListModel is
///   // concerned). The widget will be used by the
///   // [AnimatedListState.removeItem] method's
///   // [AnimatedListRemovedItemBuilder] parameter.
///   Widget _buildRemovedItem(int item, BuildContext context, Animation<double> animation) {
///     return CardItem(
///       animation: animation,
///       item: item,
///       selected: false,
///       // No gesture detector here: we don't want removed items to be interactive.
///     );
///   }
///
///   // Insert the "next item" into the list model.
///   void _insert() {
///     final int index = _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
///     _list.insert(index, _nextItem++);
///   }
///
///   // Remove the selected item from the list model.
///   void _remove() {
///     if (_selectedItem != null) {
///       _list.removeAt(_list.indexOf(_selectedItem));
///       setState(() {
///         _selectedItem = null;
///       });
///     }
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       home: Scaffold(
///         appBar: AppBar(
///           title: const Text('AnimatedList'),
///           actions: <Widget>[
///             IconButton(
///               icon: const Icon(Icons.add_circle),
///               onPressed: _insert,
///               tooltip: 'insert a new item',
///             ),
///             IconButton(
///               icon: const Icon(Icons.remove_circle),
///               onPressed: _remove,
///               tooltip: 'remove the selected item',
///             ),
///           ],
///         ),
///         body: Padding(
///           padding: const EdgeInsets.all(16.0),
///           child: AnimatedList(
///             key: _listKey,
///             initialItemCount: _list.length,
///             itemBuilder: _buildItem,
///           ),
///         ),
///       ),
///     );
///   }
/// }
///
/// /// Keeps a Dart [List] in sync with an [AnimatedList].
/// ///
/// /// The [insert] and [removeAt] methods apply to both the internal list and
/// /// the animated list that belongs to [listKey].
/// ///
/// /// This class only exposes as much of the Dart List API as is needed by the
/// /// sample app. More list methods are easily added, however methods that
/// /// mutate the list must make the same changes to the animated list in terms
/// /// of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
/// class ListModel<E> {
///   ListModel({
///     @required this.listKey,
///     @required this.removedItemBuilder,
///     Iterable<E> initialItems,
///   }) : assert(listKey != null),
///       assert(removedItemBuilder != null),
///       _items = List<E>.from(initialItems ?? <E>[]);
///
///   final GlobalKey<AnimatedListState> listKey;
///   final dynamic removedItemBuilder;
///   final List<E> _items;
///
///   AnimatedListState get _animatedList => listKey.currentState;
///
///   void insert(int index, E item) {
///     _items.insert(index, item);
///     _animatedList.insertItem(index);
///   }
///
///   E removeAt(int index) {
///     final E removedItem = _items.removeAt(index);
///     if (removedItem != null) {
///       _animatedList.removeItem(
///         index,
///           (BuildContext context, Animation<double> animation) => removedItemBuilder(removedItem, context, animation),
///       );
///     }
///     return removedItem;
///   }
///
///   int get length => _items.length;
///
///   E operator [](int index) => _items[index];
///
///   int indexOf(E item) => _items.indexOf(item);
/// }
///
/// /// Displays its integer item as 'item N' on a Card whose color is based on
/// /// the item's value.
/// ///
/// /// The text is displayed in bright green if [selected] is
/// /// true. This widget's height is based on the [animation] parameter, it
/// /// varies from 0 to 128 as the animation varies from 0.0 to 1.0.
/// class CardItem extends StatelessWidget {
///   const CardItem({
///     Key key,
///     @required this.animation,
///     this.onTap,
///     @required this.item,
///     this.selected: false
///   }) : assert(animation != null),
///        assert(item != null && item >= 0),
///        assert(selected != null),
///        super(key: key);
///
///   final Animation<double> animation;
///   final VoidCallback onTap;
///   final int item;
///   final bool selected;
///
///   @override
///   Widget build(BuildContext context) {
///     TextStyle textStyle = Theme.of(context).textTheme.headline4;
///     if (selected)
///       textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
///     return Padding(
///       padding: const EdgeInsets.all(2.0),
///       child: SizeTransition(
///         axis: Axis.vertical,
///         sizeFactor: animation,
///         child: GestureDetector(
///           behavior: HitTestBehavior.opaque,
///           onTap: onTap,
///           child: SizedBox(
///             height: 80.0,
///             child: Card(
///               color: Colors.primaries[item % Colors.primaries.length],
///               child: Center(
///                 child: Text('Item $item', style: textStyle),
///               ),
///             ),
///           ),
///         ),
///       ),
///     );
///   }
/// }
///
/// void main() {
///   runApp(AnimatedListSample());
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CustomSliverAnimatedList], a sliver that animates items when they are inserted
///    or removed from a list.
class CustomAnimatedList extends StatefulWidget {
  /// Creates a scrolling container that animates items when they are inserted
  /// or removed.
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
  }) : assert(itemBuilder != null),
        assert(initialItemCount != null && initialItemCount >= 0),
        super(key: key);

  /// Called, as needed, to build list item widgets.
  ///
  /// List items are only built when they're scrolled into view.
  ///
  /// The [AnimatedListItemBuilder] index parameter indicates the item's
  /// position in the list. The value of the index parameter will be between 0
  /// and [initialItemCount] plus the total number of items that have been
  /// inserted with [CustomAnimatedListState.insertItem] and less the total number of
  /// items that have been removed with [CustomAnimatedListState.removeItem].
  ///
  /// Implementations of this callback should assume that
  /// [CustomAnimatedListState.removeItem] removes an item immediately.
  final AnimatedListItemBuilder itemBuilder;

  /// {@template flutter.widgets.animatedList.initialItemCount}
  /// The number of items the list will start with.
  ///
  /// The appearance of the initial items is not animated. They
  /// are created, as needed, by [itemBuilder] with an animation parameter
  /// of [kAlwaysCompleteAnimation].
  /// {@endtemplate}
  final int initialItemCount;

  /// The axis along which the scroll view scrolls.
  ///
  /// Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the scroll view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the scroll view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// An object that can be used to control the position to which this scroll
  /// view is scrolled.
  ///
  /// Must be null if [primary] is true.
  ///
  /// A [ScrollController] serves several purposes. It can be used to control
  /// the initial scroll position (see [ScrollController.initialScrollOffset]).
  /// It can be used to control whether the scroll view should automatically
  /// save and restore its scroll position in the [PageStorage] (see
  /// [ScrollController.keepScrollOffset]). It can be used to read the current
  /// scroll position (see [ScrollController.offset]), or change it (see
  /// [ScrollController.animateTo]).
  final ScrollController controller;

  /// Whether this is the primary scroll view associated with the parent
  /// [PrimaryScrollController].
  ///
  /// On iOS, this identifies the scroll view that will scroll to top in
  /// response to a tap in the status bar.
  ///
  /// Defaults to true when [scrollDirection] is [Axis.vertical] and
  /// [controller] is null.
  final bool primary;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics physics;

  /// Whether the extent of the scroll view in the [scrollDirection] should be
  /// determined by the contents being viewed.
  ///
  /// If the scroll view does not shrink wrap, then the scroll view will expand
  /// to the maximum allowed size in the [scrollDirection]. If the scroll view
  /// has unbounded constraints in the [scrollDirection], then [shrinkWrap] must
  /// be true.
  ///
  /// Shrink wrapping the content of the scroll view is significantly more
  /// expensive than expanding to the maximum allowed size because the content
  /// can expand and contract during scrolling, which means the size of the
  /// scroll view needs to be recomputed whenever the scroll position changes.
  ///
  /// Defaults to false.
  final bool shrinkWrap;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry padding;

  /// The state from the closest instance of this class that encloses the given
  /// context.
  ///
  /// This method is typically used by [CustomAnimatedList] item widgets that insert
  /// or remove items in response to user input.
  ///
  /// ```dart
  /// AnimatedListState animatedList = AnimatedList.of(context);
  /// ```
  static CustomAnimatedListState of(BuildContext context, { bool nullOk = false }) {
    assert(context != null);
    assert(nullOk != null);
    final CustomAnimatedListState result = context.findAncestorStateOfType<CustomAnimatedListState>();
    if (nullOk || result != null)
      return result;
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('AnimatedList.of() called with a context that does not contain an AnimatedList.'),
      ErrorDescription('No AnimatedList ancestor could be found starting from the context that was passed to AnimatedList.of().'),
      ErrorHint(
          'This can happen when the context provided is from the same StatefulWidget that '
              'built the AnimatedList. Please see the AnimatedList documentation for examples '
              'of how to refer to an AnimatedListState object:'
              '  https://api.flutter.dev/flutter/widgets/AnimatedListState-class.html'
      ),
      context.describeElement('The context used was')
    ]);
  }

  @override
  CustomAnimatedListState createState() => CustomAnimatedListState();
}

/// The state for a scrolling container that animates items when they are
/// inserted or removed.
///
/// When an item is inserted with [insertItem] an animation begins running. The
/// animation is passed to [CustomAnimatedList.itemBuilder] whenever the item's widget
/// is needed.
///
/// When an item is removed with [removeItem] its animation is reversed.
/// The removed item's animation is passed to the [removeItem] builder
/// parameter.
///
/// An app that needs to insert or remove items in response to an event
/// can refer to the [CustomAnimatedList]'s state with a global key:
///
/// ```dart
/// GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
/// ...
/// AnimatedList(key: listKey, ...);
/// ...
/// listKey.currentState.insert(123);
/// ```
///
/// [CustomAnimatedList] item input handlers can also refer to their [CustomAnimatedListState]
/// with the static [CustomAnimatedList.of] method.
class CustomAnimatedListState extends State<CustomAnimatedList> with TickerProviderStateMixin<CustomAnimatedList> {
  final GlobalKey<CustomSliverAnimatedListState> _sliverAnimatedListKey = GlobalKey();

  /// Insert an item at [index] and start an animation that will be passed
  /// to [CustomAnimatedList.itemBuilder] when the item is visible.
  ///
  /// This method's semantics are the same as Dart's [List.insert] method:
  /// it increases the length of the list by one and shifts all items at or
  /// after [index] towards the end of the list.
  void insertItem(int index, { Duration duration = _kDuration }) {
    _sliverAnimatedListKey.currentState.insertItem(index, duration: duration);
  }

  /// Remove the item at [index] and start an animation that will be passed
  /// to [builder] when the item is visible.
  ///
  /// Items are removed immediately. After an item has been removed, its index
  /// will no longer be passed to the [CustomAnimatedList.itemBuilder]. However the
  /// item will still appear in the list for [duration] and during that time
  /// [builder] must construct its widget as needed.
  ///
  /// This method's semantics are the same as Dart's [List.remove] method:
  /// it decreases the length of the list by one and shifts all items at or
  /// before [index] towards the beginning of the list.
  void removeItem(int index, AnimatedListRemovedItemBuilder builder, { Duration duration = _kDuration }) {
    _sliverAnimatedListKey.currentState.removeItem(index, builder, duration: duration);
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

/// A sliver that animates items when they are inserted or removed.
///
/// This widget's [CustomSliverAnimatedListState] can be used to dynamically insert or
/// remove items. To refer to the [CustomSliverAnimatedListState] either provide a
/// [GlobalKey] or use the static [CustomSliverAnimatedList.of] method from an item's
/// input callback.
///
/// {@tool dartpad --template=freeform}
/// This sample application uses a [CustomSliverAnimatedList] to create an animated
/// effect when items are removed or added to the list.
///
/// ```dart imports
/// import 'package:flutter/foundation.dart';
/// import 'package:flutter/material.dart';
/// ```
///
/// ```dart
/// void main() => runApp(SliverAnimatedListSample());
///
/// class SliverAnimatedListSample extends StatefulWidget {
///   @override
///   _SliverAnimatedListSampleState createState() => _SliverAnimatedListSampleState();
/// }
///
/// class _SliverAnimatedListSampleState extends State<SliverAnimatedListSample> {
///   final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
///   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
///   ListModel<int> _list;
///   int _selectedItem;
///   int _nextItem; // The next item inserted when the user presses the '+' button.
///
///   @override
///   void initState() {
///     super.initState();
///     _list = ListModel<int>(
///       listKey: _listKey,
///       initialItems: <int>[0, 1, 2],
///       removedItemBuilder: _buildRemovedItem,
///     );
///     _nextItem = 3;
///   }
///
///   // Used to build list items that haven't been removed.
///   Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
///     return CardItem(
///       animation: animation,
///       item: _list[index],
///       selected: _selectedItem == _list[index],
///       onTap: () {
///         setState(() {
///           _selectedItem = _selectedItem == _list[index] ? null : _list[index];
///         });
///       },
///     );
///   }
///
///   // Used to build an item after it has been removed from the list. This
///   // method is needed because a removed item remains visible until its
///   // animation has completed (even though it's gone as far this ListModel is
///   // concerned). The widget will be used by the
///   // [AnimatedListState.removeItem] method's
///   // [AnimatedListRemovedItemBuilder] parameter.
///   Widget _buildRemovedItem(int item, BuildContext context, Animation<double> animation) {
///     return CardItem(
///       animation: animation,
///       item: item,
///       selected: false,
///     );
///   }
///
///   // Insert the "next item" into the list model.
///   void _insert() {
///     final int index = _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
///     _list.insert(index, _nextItem++);
///   }
///
///   // Remove the selected item from the list model.
///   void _remove() {
///     if (_selectedItem != null) {
///       _list.removeAt(_list.indexOf(_selectedItem));
///       setState(() {
///         _selectedItem = null;
///       });
///     } else {
///       _scaffoldKey.currentState.showSnackBar(SnackBar(
///         content: Text(
///           'Select an item to remove from the list.',
///           style: TextStyle(fontSize: 20),
///         ),
///       ));
///     }
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       home: Scaffold(
///         key: _scaffoldKey,
///         body: CustomScrollView(
///           slivers: <Widget>[
///             SliverAppBar(
///               title: Text(
///                 'SliverAnimatedList',
///                 style: TextStyle(fontSize: 30),
///               ),
///               expandedHeight: 60,
///               centerTitle: true,
///               backgroundColor: Colors.amber[900],
///               leading: IconButton(
///                 icon: const Icon(Icons.add_circle),
///                 onPressed: _insert,
///                 tooltip: 'Insert a new item.',
///                 iconSize: 32,
///               ),
///               actions: [
///                 IconButton(
///                   icon: const Icon(Icons.remove_circle),
///                   onPressed: _remove,
///                   tooltip: 'Remove the selected item.',
///                   iconSize: 32,
///                 ),
///               ],
///             ),
///             SliverAnimatedList(
///               key: _listKey,
///               initialItemCount: _list.length,
///               itemBuilder: _buildItem,
///             ),
///           ],
///         ),
///       ),
///     );
///   }
/// }
///
/// // Keeps a Dart [List] in sync with an [AnimatedList].
/// //
/// // The [insert] and [removeAt] methods apply to both the internal list and
/// // the animated list that belongs to [listKey].
/// //
/// // This class only exposes as much of the Dart List API as is needed by the
/// // sample app. More list methods are easily added, however methods that
/// // mutate the list must make the same changes to the animated list in terms
/// // of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
/// class ListModel<E> {
///   ListModel({
///     @required this.listKey,
///     @required this.removedItemBuilder,
///     Iterable<E> initialItems,
///   }) : assert(listKey != null),
///        assert(removedItemBuilder != null),
///        _items = List<E>.from(initialItems ?? <E>[]);
///
///   final GlobalKey<SliverAnimatedListState> listKey;
///   final dynamic removedItemBuilder;
///   final List<E> _items;
///
///   SliverAnimatedListState get _animatedList => listKey.currentState;
///
///   void insert(int index, E item) {
///     _items.insert(index, item);
///     _animatedList.insertItem(index);
///   }
///
///   E removeAt(int index) {
///     final E removedItem = _items.removeAt(index);
///     if (removedItem != null) {
///       _animatedList.removeItem(
///         index,
///         (BuildContext context, Animation<double> animation) => removedItemBuilder(removedItem, context, animation),
///       );
///     }
///     return removedItem;
///   }
///
///   int get length => _items.length;
///
///   E operator [](int index) => _items[index];
///
///   int indexOf(E item) => _items.indexOf(item);
/// }
///
/// // Displays its integer item as 'Item N' on a Card whose color is based on
/// // the item's value.
/// //
/// // The card turns gray when [selected] is true. This widget's height
/// // is based on the [animation] parameter. It varies as the animation value
/// // transitions from 0.0 to 1.0.
/// class CardItem extends StatelessWidget {
///   const CardItem({
///     Key key,
///     @required this.animation,
///     @required this.item,
///     this.onTap,
///     this.selected = false,
///   }) : assert(animation != null),
///        assert(item != null && item >= 0),
///        assert(selected != null),
///        super(key: key);
///
///   final Animation<double> animation;
///   final VoidCallback onTap;
///   final int item;
///   final bool selected;
///
///   @override
///   Widget build(BuildContext context) {
///     return Padding(
///       padding:
///       const EdgeInsets.only(
///         left: 2.0,
///         right: 2.0,
///         top: 2.0,
///         bottom: 0.0,
///       ),
///       child: SizeTransition(
///         axis: Axis.vertical,
///         sizeFactor: animation,
///         child: GestureDetector(
///           onTap: onTap,
///           child: SizedBox(
///             height: 80.0,
///             child: Card(
///               color: selected
///                 ? Colors.black12
///                 : Colors.primaries[item % Colors.primaries.length],
///               child: Center(
///                 child: Text(
///                   'Item $item',
///                   style: Theme.of(context).textTheme.headline4,
///                 ),
///               ),
///             ),
///           ),
///         ),
///       ),
///     );
///   }
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [SliverList], which does not animate items when they are inserted or
///    removed.
///  * [CustomAnimatedList], a non-sliver scrolling container that animates items when
///    they are inserted or removed.
class CustomSliverAnimatedList extends StatefulWidget {
  /// Creates a sliver that animates items when they are inserted or removed.
  const CustomSliverAnimatedList({
    Key key,
    @required this.itemBuilder,
    this.initialItemCount = 0,
  }) : assert(itemBuilder != null),
        assert(initialItemCount != null && initialItemCount >= 0),
        super(key: key);

  /// Called, as needed, to build list item widgets.
  ///
  /// List items are only built when they're scrolled into view.
  ///
  /// The [AnimatedListItemBuilder] index parameter indicates the item's
  /// position in the list. The value of the index parameter will be between 0
  /// and [initialItemCount] plus the total number of items that have been
  /// inserted with [CustomSliverAnimatedListState.insertItem] and less the total
  /// number of items that have been removed with
  /// [CustomSliverAnimatedListState.removeItem].
  ///
  /// Implementations of this callback should assume that
  /// [CustomSliverAnimatedListState.removeItem] removes an item immediately.
  final AnimatedListItemBuilder itemBuilder;

  /// {@macro flutter.widgets.animatedList.initialItemCount}
  final int initialItemCount;

  @override
  CustomSliverAnimatedListState createState() => CustomSliverAnimatedListState();

  /// The state from the closest instance of this class that encloses the given
  /// context.
  ///
  /// This method is typically used by [CustomSliverAnimatedList] item widgets that
  /// insert or remove items in response to user input.
  ///
  /// ```dart
  /// SliverAnimatedListState animatedList = SliverAnimatedList.of(context);
  /// ```
  static CustomSliverAnimatedListState of(BuildContext context, {bool nullOk = false}) {
    assert(context != null);
    assert(nullOk != null);
    final CustomSliverAnimatedListState result = context.findAncestorStateOfType<CustomSliverAnimatedListState>();
    if (nullOk || result != null)
      return result;
    throw FlutterError(
        'SliverAnimatedList.of() called with a context that does not contain a SliverAnimatedList.\n'
            'No SliverAnimatedListState ancestor could be found starting from the '
            'context that was passed to SliverAnimatedListState.of(). This can '
            'happen when the context provided is from the same StatefulWidget that '
            'built the AnimatedList. Please see the SliverAnimatedList documentation '
            'for examples of how to refer to an AnimatedListState object: '
            'https://docs.flutter.io/flutter/widgets/SliverAnimatedListState-class.html \n'
            'The context used was:\n'
            '  $context');
  }
}

/// The state for a sliver that animates items when they are
/// inserted or removed.
///
/// When an item is inserted with [insertItem] an animation begins running. The
/// animation is passed to [CustomSliverAnimatedList.itemBuilder] whenever the item's
/// widget is needed.
///
/// When an item is removed with [removeItem] its animation is reversed.
/// The removed item's animation is passed to the [removeItem] builder
/// parameter.
///
/// An app that needs to insert or remove items in response to an event
/// can refer to the [CustomSliverAnimatedList]'s state with a global key:
///
/// ```dart
/// GlobalKey<SliverAnimatedListState> listKey = GlobalKey<SliverAnimatedListState>();
/// ...
/// SliverAnimatedList(key: listKey, ...);
/// ...
/// listKey.currentState.insert(123);
/// ```
///
/// [CustomSliverAnimatedList] item input handlers can also refer to their
/// [CustomSliverAnimatedListState] with the static [CustomSliverAnimatedList.of] method.
class CustomSliverAnimatedListState extends State<CustomSliverAnimatedList> with TickerProviderStateMixin {

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
    if(widget.initialItemCount != _itemsCount) {
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

  // The insertItem() and removeItem() index parameters are defined as if the
  // removeItem() operation removed the corresponding list entry immediately.
  // The entry is only actually removed from the ListView when the remove animation
  // finishes. The entry is added to _outgoingItems when removeItem is called
  // and removed from _outgoingItems when the remove animation finishes.

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
      assert(item.itemIndex != itemIndex);
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

  /// Insert an item at [index] and start an animation that will be passed to
  /// [CustomSliverAnimatedList.itemBuilder] when the item is visible.
  ///
  /// This method's semantics are the same as Dart's [List.insert] method:
  /// it increases the length of the list by one and shifts all items at or
  /// after [index] towards the end of the list.
  void insertItem(int index, { Duration duration = _kDuration }) {
    assert(index != null && index >= 0);
    assert(duration != null);

    final int itemIndex = _indexToItemIndex(index);
    assert(itemIndex >= 0 && itemIndex <= _itemsCount);

    // Increment the incoming and outgoing item indices to account
    // for the insertion.
    for (final _ActiveItem item in _incomingItems) {
      if (item.itemIndex >= itemIndex)
        item.itemIndex += 1;
    }
    for (final _ActiveItem item in _outgoingItems) {
      if (item.itemIndex >= itemIndex)
        item.itemIndex += 1;
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
      _removeActiveItemAt(_incomingItems, incomingItem.itemIndex).controller.dispose();
    });
  }

  /// Remove the item at [index] and start an animation that will be passed
  /// to [builder] when the item is visible.
  ///
  /// Items are removed immediately. After an item has been removed, its index
  /// will no longer be passed to the [CustomSliverAnimatedList.itemBuilder]. However
  /// the item will still appear in the list for [duration] and during that time
  /// [builder] must construct its widget as needed.
  ///
  /// This method's semantics are the same as Dart's [List.remove] method:
  /// it decreases the length of the list by one and shifts all items at or
  /// before [index] towards the beginning of the list.
  void removeItem(int index, AnimatedListRemovedItemBuilder builder, { Duration duration = _kDuration }) {
    assert(index != null && index >= 0);
    assert(builder != null);
    assert(duration != null);

    final int itemIndex = _indexToItemIndex(index);
    assert(itemIndex >= 0 && itemIndex < _itemsCount);
    assert(_activeItemAt(_outgoingItems, itemIndex) == null);

    final _ActiveItem incomingItem = _removeActiveItemAt(_incomingItems, itemIndex);
    final AnimationController controller = incomingItem?.controller
        ?? AnimationController(duration: duration, value: 1.0, vsync: this);
    final _ActiveItem outgoingItem = _ActiveItem.outgoing(controller, itemIndex, builder);
    setState(() {
      _outgoingItems
        ..add(outgoingItem)
        ..sort();
    });

    controller.reverse().then<void>((void value) {
      _removeActiveItemAt(_outgoingItems, outgoingItem.itemIndex).controller.dispose();

      // Decrement the incoming and outgoing item indices to account
      // for the removal.
      for (final _ActiveItem item in _incomingItems) {
        if (item.itemIndex > outgoingItem.itemIndex)
          item.itemIndex -= 1;
      }
      for (final _ActiveItem item in _outgoingItems) {
        if (item.itemIndex > outgoingItem.itemIndex)
          item.itemIndex -= 1;
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
    final Animation<double> animation = incomingItem?.controller?.view ?? kAlwaysCompleteAnimation;
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
