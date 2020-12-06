import 'package:demo/bloc/index.dart';
import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlutterBlocDemo extends StatefulWidget {
  @override
  _FlutterBlocDemoState createState() => _FlutterBlocDemoState();
}

class _FlutterBlocDemoState extends State<FlutterBlocDemo> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (BuildContext context) => CounterBloc(),
      child: _CounterWidget(),
    );
  }
}

class _CounterWidget extends StatelessWidget {
  const _CounterWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (BuildContext context, CounterState state) {
          Log.info('BlocBuilder', StackTrace.current);
          return Center(
            child: Text(
              '${state.counter}',
              style: TextStyle(fontSize: 50),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterBloc>().onIncrement(),
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () => context.read<CounterBloc>().onDecrement(),
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
