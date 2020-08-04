import 'package:demo/NavigatorUtil.dart';
import 'package:demo/model/CounterModel.dart';
import 'package:demo/pages/ProviderSecondPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderFirstPage extends StatelessWidget {
  static const rName = 'ProviderFirstPage';

  @override
  Widget build(BuildContext context) {
    print(rName);
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context).toDouble();
    return Scaffold(
      appBar: AppBar(
        title: Text('ProviderFirstPage'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Text(
            'Value: ${_counter.value}',
            style: TextStyle(fontSize: textSize),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NavigatorUtil.getInstance()
            .pushNamed(context, ProviderSecondPage.rName),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
