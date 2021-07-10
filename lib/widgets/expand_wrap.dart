import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class ExpandWrap extends StatefulWidget {
  const ExpandWrap({
    Key? key,
    required this.children,
    required this.line,
    this.expand = true,
    required this.button,
  }) : super(key: key);
  final List<Widget> children;
  final int line;
  final bool expand;
  final Widget button;

  @override
  _ExpandWrapState createState() => _ExpandWrapState();
}

class _ExpandWrapState extends State<ExpandWrap> {
  late List<Widget> children = widget.children;
  List<BuildContext> contextList = [];
  double minDy = double.minPositive;
  double _line = 1;
  int _index = -1;

  getChildOffsetAndSize(int index, Size size, Offset offset) {
    if (offset.dy > minDy && _index == -1) {
      _line++;
      minDy = offset.dy;
      if (_line > widget.line) {
        setState(() {
          _index = index;
        });
      }
    }
  }

  bool get expand => widget.expand;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: buildBuilderChildren(),
        ),
      ],
    );
  }

  List<Widget> buildBuilderChildren() {
    List<Widget> _children = [];
    for (int i = 0; i < children.length; i++) {
      if (_index == -1 || i < _index || expand == false) {
        _children.add(_GetSizeOffset(
          sizeOffsetCallback: getChildOffsetAndSize,
          index: i,
          child: children[i],
        ));
      }
    }
    if(_index == -1 && expand == true) {
      _children.add(widget.button);
    }
    return _children;
  }
}

typedef SizeOffsetCallback = void Function(int index, Size size, Offset offset);

class _GetSizeOffset extends StatefulWidget {
  final SizeOffsetCallback sizeOffsetCallback;
  final int index;
  final Widget child;

  const _GetSizeOffset({
    Key? key,
    required this.sizeOffsetCallback,
    required this.index,
    required this.child,
  }) : super(key: key);

  @override
  _GetSizeOffsetState createState() => _GetSizeOffsetState();
}

class _GetSizeOffsetState extends State<_GetSizeOffset> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      RenderBox? renderBox = context.findRenderObject() as RenderBox;
      widget.sizeOffsetCallback(
        widget.index,
        renderBox.size,
        renderBox.localToGlobal(Offset.zero),
      );
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
