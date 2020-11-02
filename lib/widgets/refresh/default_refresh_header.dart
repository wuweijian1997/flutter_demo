import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class DefaultRefreshHeader extends StatefulWidget {
  final RefreshState refreshState;
  final double pulledExtent;
  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;

  DefaultRefreshHeader({
    this.refreshState,
    this.pulledExtent,
    this.refreshTriggerPullDistance,
    this.refreshIndicatorExtent,
  });

  @override
  _DefaultRefreshHeaderState createState() => _DefaultRefreshHeaderState();
}

class _DefaultRefreshHeaderState extends State<DefaultRefreshHeader> {
  double get refreshIndicatorExtent => widget.refreshIndicatorExtent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: null,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: refreshIndicatorExtent,
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              width: double.infinity,
              alignment: Alignment.center,
              child: CustomLoading(),
            ),
          ),
        ),
      ],
    );
  }
}
