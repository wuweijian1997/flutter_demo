import 'package:demo/model/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

import 'index.dart';

class PictureFragmentsPage extends StatefulWidget {
  static const String rName = 'Fragments';

  @override
  _PictureFragmentsPageState createState() => _PictureFragmentsPageState();
}

class _PictureFragmentsPageState extends State<PictureFragmentsPage> {
  final List<ListPageModel> list = [
    ListPageModel(
      title: 'Default',
      page: _PictureDetail(
        delegate: RadialFragmentsDraw(disableTransition: true),
      ),
    ),
    ListPageModel(
      title: 'Transition',
      page: _PictureDetail(
        delegate: RadialFragmentsDraw(numberOfRow: 20, numberOfColumn: 20),
      ),
    ),
    ListPageModel(
      title: 'Custom Number',
      page: _PictureDetail(
        delegate: RadialFragmentsDraw(numberOfRow: 25, numberOfColumn: 25),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPage(list),
    );
  }
}

class _PictureDetail extends StatefulWidget {
  final FragmentsDrawDelegate delegate;

  _PictureDetail({required this.delegate});

  @override
  __PictureDetailState createState() => __PictureDetailState();
}

class __PictureDetailState extends State<_PictureDetail> {
  Offset startingPoint = Offset.zero;

  FragmentsDrawDelegate get delegate => widget.delegate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: Stack(
            children: [
              GestureFragments(delegate: delegate, child: FragmentsExample()),
            ],
          ),
        ),
      ),
    );
  }
}
