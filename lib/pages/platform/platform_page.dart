import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';


class PlatformPage extends StatelessWidget {
  static const String rName = "Platform";

  final List<ListPageModel> list = [
    ListPageModel(title: MethodChannelPage.rName, page: MethodChannelPage()),
    ListPageModel(title: EventChannelPage.rName, page: EventChannelPage()),
    ListPageModel(title: BasicMessageChannelPage.rName, page: BasicMessageChannelPage()),
    ListPageModel(title: PetListPage.rName, page: PetListPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPage(list),
    );
  }
}
