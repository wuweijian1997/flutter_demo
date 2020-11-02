import 'package:demo/util/assets_util.dart';
import 'package:demo/widgets/render_object/index.dart';
import 'package:flutter/material.dart';

class SliverWeChatHomeDropDown extends StatefulWidget {
  final Widget child;
  final double layoutExtent;

  SliverWeChatHomeDropDown(
      {Key key, @required this.child, this.layoutExtent = 1000})
      : super(key: key);

  @override
  _SliverWeChatHomeDropDownState createState() =>
      _SliverWeChatHomeDropDownState();
}

class _SliverWeChatHomeDropDownState extends State<SliverWeChatHomeDropDown> {
  bool hasLayoutExtent = false;
  double dropDownBoxExtent = 0.0;

  @override
  Widget build(BuildContext context) {
    return WeChatDropDown(
      hasLayoutExtent: hasLayoutExtent,
      layoutExtent: widget.layoutExtent,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          dropDownBoxExtent = constraints.maxHeight;
          return _DefaultDropDownPage();
        },
      ),
    );
  }
}

class _DefaultDropDownPage extends StatefulWidget {
  final double dropDownBoxExtent;

  _DefaultDropDownPage({this.dropDownBoxExtent});

  @override
  _DefaultDropDownPageState createState() => _DefaultDropDownPageState();
}

class _DefaultDropDownPageState extends State<_DefaultDropDownPage> {
  double get dropDownBoxExtent => widget.dropDownBoxExtent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: null,
          child: Container(
            color: Colors.grey[300],
            child: Image.asset(Assets.rem),
          ),
        ),
        Container(
          color: Colors.grey[300],

        ),
      ],
    );
  }
}
