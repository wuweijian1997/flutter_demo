import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfiniteProcessPage extends StatelessWidget {
  static const String rName = "InfiniteProcess";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InfiniteProcessController(),
      child: Container(),
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
      if (message is SendPort) {
        newIceSP = message;
        newIceSP.send(_currentResults);
      } else if (message is int) {
        setCurrentResults(message);
      }
    });
  }

  Future<void> start() async {
    if(_created == false && _paused == false) {
      await createIsolate();
      listen();
      _created = true;
      notifyListeners();
    }
  }

  void setCurrentResults(int newNum) {
    _currentResults.insert(0,newNum);
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
  newIceRP.listen((dynamic message) {
    if (message is int) {
      multiplyValue = message;
    }
  });

  while (true) {
    var sum = 0;
    for (int i = 0; i< 10000; i++) {
      sum += await doSomeWork();
    }
    callerSP.send(sum * multiplyValue);
  }
}

Future<int> doSomeWork() {
  var random = Random();
  return Future(() {
    var sum = 0;
    for (var i = 0; i< 1000;i++) {
      sum += random.nextInt(100);
    }
    return sum;
  })
}
