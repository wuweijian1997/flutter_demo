import 'dart:isolate';
import 'dart:math';

import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfiniteProcessPage extends StatelessWidget {
  static const String rName = "InfiniteProcess";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => InfiniteProcessController(),
        child: Builder(
          builder: (context) {
            final controller = Provider.of<InfiniteProcessController>(context);
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Summation Results",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Expanded(
                    child: RunningList(),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            child: const Text("Start"),
                            elevation: 8.0,
                            onPressed: () => controller.start(),
                          ),
                          RaisedButton(
                            child: const Text("Terminate"),
                            elevation: 8.0,
                            onPressed: () => controller.terminate(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Switch(
                            value: !controller.paused,
                            onChanged: (_) => controller.pausedSwitch(),
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.black,
                            inactiveTrackColor: Colors.deepOrangeAccent,
                            inactiveThumbColor: Colors.black,
                          ),
                          Text("Pause/Resume"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 1; i <= 3; i++) ...[
                            Radio<int>(
                              value: i,
                              groupValue: controller.currentMultiplier,
                              onChanged: (val) => controller.setMultiplier(val),
                            ),
                            Text('${i}X')
                          ]
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class RunningList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<InfiniteProcessController>(context);
    var sums = controller.currentResults;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: ListView.builder(
        itemCount: sums.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                child: ListTile(
                  leading: Text('${sums.length - index}.'),
                  title: Text('${sums[index]}.'),
                ),
                color: (controller.created && !controller.paused)
                    ? Colors.lightGreenAccent
                    : Colors.deepOrangeAccent,
              ),
              Divider(
                color: Colors.blue,
                height: 3,
              )
            ],
          );
        },
      ),
    );
  }
}

class InfiniteProcessController extends ChangeNotifier {
  Isolate newIsolate;
  ReceivePort receivePort;
  SendPort newIceSP;
  Capability capability;

  int _currentMultiplier = 1;
  final List<int> _currentResults = [];
  bool _created = false;
  bool _paused = false;

  int get currentMultiplier => _currentMultiplier;

  bool get paused => _paused;

  bool get created => _created;

  List<int> get currentResults => _currentResults;

  Future<void> createIsolate() async {
    receivePort = ReceivePort();
    newIsolate =
        await Isolate.spawn(_secondIsolateEntryPoint, receivePort.sendPort);
  }

  void listen() {
    receivePort.listen((dynamic message) {
      Log.info('message: $message, Type: ${message.runtimeType}',
          StackTrace.current);
      if (message is SendPort) {
        newIceSP = message;
        newIceSP.send(_currentResults);
      } else if (message is int) {
        setCurrentResults(message);
      }
    });
  }

  Future<void> start() async {
    if (_created == false && _paused == false) {
      await createIsolate();
      listen();
      _created = true;
      notifyListeners();
    }
  }

  ///终止
  void terminate() {
    newIsolate.kill();
    _created = false;
    _currentResults.clear();
    notifyListeners();
  }

  ///暂停开关
  void pausedSwitch() {
    if (_paused) {
      newIsolate.resume(capability);
    } else {
      capability = newIsolate.pause();
    }
    _paused = !_paused;
    notifyListeners();
  }

  void setMultiplier(int newMultiplier) {
    _currentMultiplier = newMultiplier;
    newIceSP.send(_currentMultiplier);
    notifyListeners();
  }

  void setCurrentResults(int newNum) {
    _currentResults.insert(0, newNum);
    notifyListeners();
  }

  @override
  void dispose() {
    newIsolate?.kill(priority: Isolate.immediate);
    super.dispose();
  }
}

Future<void> _secondIsolateEntryPoint(SendPort callerSP) async {
  var multiplyValue = 1;
  var newIceRP = ReceivePort();
  callerSP.send(newIceRP.sendPort);
  newIceRP.listen((dynamic message) {
    if (message is int) {
      multiplyValue = message;
    }
  });

  while (true) {
    var sum = 0;
    for (int i = 0; i < 10000; i++) {
      sum += await doSomeWork();
    }
    callerSP.send(sum * multiplyValue);
  }
}

Future<int> doSomeWork() {
  var random = Random();
  return Future(() {
    var sum = 0;
    for (var i = 0; i < 1000; i++) {
      sum += random.nextInt(100);
    }
    return sum;
  });
}
