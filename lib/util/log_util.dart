import 'package:flutter/foundation.dart';

class Log {
  static info(String message, [StackTrace? stackTrace]) {
    log('INFO', message, stackTrace);
  }

  static error(String message, [StackTrace? stackTrace]) {
    log('ERROR', message, stackTrace);
  }

  static warning(String message, [StackTrace? stackTrace]) {
    log('WARNING', message, stackTrace);
  }

  static log(String type, String message, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      String value;
      if (stackTrace != null) {
        CustomTrace customTrace = CustomTrace(stackTrace);
        value =
            '[ ❤❤❤ $type ❤❤❤ ] ${customTrace.fileName}:(${customTrace.lineNumber}) - $message';
      } else {
        value = '[ ❤❤❤ $type ❤❤❤ ] - $message';
      }
      print(value);
    }
  }
}

class CustomTrace {
  final StackTrace _trace;

  String? fileName;
  int? lineNumber;
  int? columnNumber;

  CustomTrace(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    if (kIsWeb == true) return;
    var traceString = _trace.toString().split("\n")[0];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_/]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    var listOfInfos = fileInfo.split(":");
    fileName = listOfInfos[0];
    lineNumber = int.parse(listOfInfos[1]);
    var columnStr = listOfInfos[2];
    columnStr = columnStr.replaceFirst(")", "");
    columnNumber = int.parse(columnStr);
  }
}
