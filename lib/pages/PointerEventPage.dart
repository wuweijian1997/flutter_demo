import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PointerEventPage extends StatelessWidget {
  static final rName = 'PointerEventPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('click me AbsorbPointer');
                },
                child: AbsorbPointer(
                  child: GestureDetector(
                    onTap: () {
                      print('click me container');
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.pink,
                      child: Center(
                        child: Text('Click Me AbsorbPointer'),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('click me IgnorePointer');
                },
                child: IgnorePointer(
                  child: GestureDetector(
                    onTap: () {
                      print('click me container');
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.pink,
                      child: Center(
                        child: Text('Click Me IgnorePointer'),
                      ),
                    ),
                  ),
                ),
              ),
              Listener(
                behavior: HitTestBehavior.deferToChild,
                onPointerDown: (event) {
                  print('click me second');
                },
                child: Container(
                  child: Listener(
                    onPointerDown: (event) {
                      print('click me first');
                    },
                    behavior: HitTestBehavior.deferToChild,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.pink,
                      child: Center(
                        child: Text('Click Me double click'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
