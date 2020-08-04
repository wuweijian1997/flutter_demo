import 'package:flutter/material.dart';

class CounterModel with ChangeNotifier {
  int _count = 0;
  int get value => _count;

  void increment() {
    _count++;
    //通知听众进行刷新
    notifyListeners();
  }
}
