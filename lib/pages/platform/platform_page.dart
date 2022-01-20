import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';


class PlatformPage extends StatelessWidget {
  static const String rName = "Platform";

  final List<ListPageModel> list = [
    ListPageModel(title: MethodChannelPage.rName, page: const MethodChannelPage()),
    ListPageModel(title: EventChannelPage.rName, page: const EventChannelPage()),
    ListPageModel(title: BasicMessageChannelPage.rName, page: const BasicMessageChannelPage()),
    ListPageModel(title: PetListPage.rName, page: const PetListPage()),
  ];

  PlatformPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPage(list),
    );
  }
}
