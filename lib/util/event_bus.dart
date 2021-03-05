import 'dart:async';

class EventBus {
  StreamController _streamController;

  StreamController get streamController => _streamController;

  EventBus({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);

  EventBus.customController(StreamController controller)
      : _streamController = controller;

  /// 通过泛型来确认要监听的对象是哪个
  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  /// 发送一个类型, on根据泛型监听具体的发送的事件
  void fire(event) {
    streamController.add(event);
  }

  void destroy() {
    _streamController.close();
  }
}