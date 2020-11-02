import 'package:demo/model/clone_list_item_model.dart';
import 'package:demo/navigator_util.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class ClonePage extends StatefulWidget {
  static const String rName = "Clone";

  @override
  _CloneState createState() => _CloneState();
}

class _CloneState extends State<ClonePage> {
  List<CloneListItemModel> list = [];

  @override
  void initState() {
    super.initState();
    list = [
      CloneListItemModel(
          title: '微信下拉', onPress: () => toPage(WeChatHomeDropDown.rName)),
      CloneListItemModel(title: '淘宝下拉'),
    ];
  }

  toPage(rName) => NavigatorUtil.getInstance().pushNamed(context, rName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListCard(
        list: list,
      ),
    );
  }
}
