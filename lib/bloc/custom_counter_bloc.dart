import 'dart:async';

import 'event/index.dart';


class CustomCounterBloc {
  int _counter = 0;

  ///Stream 的 状态控制器 state
  final StreamController<int> _counterStateController = StreamController<int>();
  ///Stream 的 状态 通知
  StreamSink<int> get _inCounter => _counterStateController.sink;
  /// state output. state的输出
  Stream<int> get counter => _counterStateController.stream;
  /// Stream的event控制器
  final StreamController<CounterEvent> _counterEventController = StreamController<CounterEvent>();
  /// event input
  /// 事件输入
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CustomCounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if(event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}