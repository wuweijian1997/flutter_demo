import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedSwitcherCounterRoute  extends StatefulWidget {
  static const rName = 'AnimatedSwitcherCounterRoute';

  @override
  _AnimatedSwitcherCounterRouteState createState() => _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState extends State<AnimatedSwitcherCounterRoute > {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  child: child,
                  scale: animation,
                );
              },
              child: Text(
                '$count',
                key: ValueKey<int>(count),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            RaisedButton(
              child: Text('+'),
              onPressed: () {
                setState(() {
                  count += 1;
                });
              },
            ),
            RaisedButton(
              child: Text('-'),
              onPressed: () {
                setState(() {
                  count -= 1;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

