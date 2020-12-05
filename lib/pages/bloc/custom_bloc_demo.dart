import 'package:demo/bloc/index.dart';
import 'package:flutter/material.dart';

class CustomBlocDemo extends StatefulWidget {
  @override
  _CustomBlocDemoState createState() => _CustomBlocDemoState();
}

class _CustomBlocDemoState extends State<CustomBlocDemo> {

  CustomCounterBloc bloc = CustomCounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: bloc.counter,
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot<int> shapshot) {
            return Text('${shapshot.data}', style: TextStyle(fontSize: 50),);
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => bloc.counterEventSink.add(IncrementEvent()),
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10,),
          FloatingActionButton(
            onPressed: () => bloc.counterEventSink.add(DecrementEvent()),
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

