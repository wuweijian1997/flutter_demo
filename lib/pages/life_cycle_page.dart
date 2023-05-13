import 'package:demo/model/counter_model.dart';
import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LifeCyclePage extends StatefulWidget {
  static String rName = 'LifeCycle';

  const LifeCyclePage({Key? key}) : super(key: key);

  @override
  State<LifeCyclePage> createState() => _LifeCyclePageState();
}

class _LifeCyclePageState extends State<LifeCyclePage> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _LifeCycle(count: count, increment: increment);
  }
}

class _LifeCycle extends StatefulWidget {
  final int count;
  final VoidCallback increment;

  const _LifeCycle({Key? key, required this.count, required this.increment}) : super(key: key);

  @override
  State<_LifeCycle> createState() => _LifeCycleState();
}

class _LifeCycleState extends State<_LifeCycle> {
  late CounterModel counterModel;

  @override
  void initState() {
    Log.info("initState");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Log.info("didChangeDependencies");
    counterModel = Provider.of<CounterModel>(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant _LifeCycle oldWidget) {
    Log.info("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Log.info("build");
    return Scaffold(
        appBar: AppBar(
          title: const Text("LifeCycle"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("counterModel.count: ${counterModel.count} widget.count: ${widget.count}"),
              GestureDetector(
                onTap: () {
                  widget.increment();
                },
                child: const Text("update widget"),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            counterModel.increment();
          },
        ));
  }

  @override
  void dispose() {
    Log.info("dispose");
    super.dispose();
  }
}
