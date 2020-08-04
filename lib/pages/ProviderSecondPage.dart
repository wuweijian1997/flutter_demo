import 'package:demo/model/CounterModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderSecondPage extends StatelessWidget {
  static const rName = 'ProviderSecondPage';

  @override
  Widget build(BuildContext context) {
    print(rName);
    return Scaffold(
      appBar: AppBar(
        title: Text('ProviderSecondPage'),
      ),
      body: Consumer2<CounterModel, int>(
        builder: (context, CounterModel counter, int textSize, _) => Center(
          child: Text(
            'Value:${counter.value}',
            style: TextStyle(
              fontSize: textSize.toDouble(),
            ),
          ),
        ),
      ),
      floatingActionButton: Consumer<CounterModel>(
        builder: (context, CounterModel counter, child) => FloatingActionButton(
          onPressed: counter.increment,
          child: child,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
