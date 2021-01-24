import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';


class PlatformPage extends StatelessWidget {
  static const String rName = "Platform";

  final List<PageRouteModel> list = [
    PageRouteModel(page: MethodChannelPage.rName),
    PageRouteModel(page: EventChannelPage.rName),
    PageRouteModel(page: BasicMessageChannelPage.rName),
    PageRouteModel(page: PetListPage.rName),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListCard(
        list: list,
      ),
    );
  }
}
