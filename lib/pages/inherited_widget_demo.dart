import 'package:flutter/material.dart';

class InheritedWidgetDemo extends StatefulWidget {
  static const rName = 'InheritedWidget';

  @override
  _InheritedWidgetDemoState createState() => _InheritedWidgetDemoState();
}

class _InheritedWidgetDemoState extends State<InheritedWidgetDemo> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CounterWidget(
          counter: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _Demo1(),
              _Demo2(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            count++;
          });
        },
      ),
    );
  }
}

class _Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int count = CounterWidget.of(context).counter;
    return Container(
      child: Text('count: $count'),
    );
  }
}

class _Demo2 extends StatefulWidget {
  @override
  _Demo2State createState() => _Demo2State();
}

class _Demo2State extends State<_Demo2> {
  @override
  Widget build(BuildContext context) {
    int count = CounterWidget.of(context).counter;
    return Container(
      child: Text('count: $count'),
    );
  }
}




class CounterWidget extends InheritedWidget {
  //1.共享数据
  final int counter;

  CounterWidget({this.counter, Widget child}) : super(child: child);

  static CounterWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(CounterWidget oldWidget) {
    return oldWidget.counter != counter;
  }
}
