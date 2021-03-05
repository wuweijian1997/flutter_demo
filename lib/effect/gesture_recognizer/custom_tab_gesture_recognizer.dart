import 'package:demo/util/index.dart';
import 'package:flutter/gestures.dart';

class CustomTapGestureRecognizer extends TapGestureRecognizer {

  final bool disable;
  final String log;

  CustomTapGestureRecognizer({this.disable = false, this.log = 'log'}):super();

  @override
  void rejectGesture(int pointer) {
    Log.info('rejectGesture: $log, $pointer', StackTrace.current);
    if(!disable) {
      acceptGesture(pointer);
    }
  }

  @override
  void acceptGesture(int pointer) {
    Log.info('acceptGesture: $log, $pointer', StackTrace.current);
    if(disable) {
      rejectGesture(pointer);
    } else {
      super.acceptGesture(pointer);
    }
  }
}