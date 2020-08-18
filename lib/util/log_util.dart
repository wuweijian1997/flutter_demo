import 'package:flutter/material.dart';

class LogUtil {
  static const paddingSize = 15;
  static const firstLineSymbol = "-->";

  static i(String tagName, [Object o, Object o1, Object o2, Object o3]) {
    StringBuffer buffer = StringBuffer();

    buffer.write(firstLineSymbol);

    buffer.write(" " * (paddingSize - tagName.length));

    buffer.write(tagName);

    [o, o1, o2, o3].forEach((o) {
      if (o != null) buffer.write(" - ${o.toString()}");
    });
    debugPrint(buffer.toString());
  }

  static e(String tagName, [Object o, Object o1, Object o2, Object o3]) {
    StringBuffer buffer = StringBuffer();

    buffer.write(firstLineSymbol);

    for (int i = 0; i < paddingSize - tagName.length; i++) {
      buffer.write(" ");
    }

    buffer.write(tagName);

    [o, o1, o2, o3].forEach((o) {
      if (o != null) buffer.write(" - ${o.toString()}");
    });
    debugPrint(buffer.toString());
  }

  static info(String message, [StackTrace stackTrace]) {
    log('INFO', message, stackTrace);
  }

  static error(String message, [StackTrace stackTrace]) {
    log('ERROR', message, stackTrace);
  }

  static warning(String message, [StackTrace stackTrace]) {
    log('WARNING', message, stackTrace);
  }

  static log(String type, String message, [StackTrace stackTrace]) {
    assert(() {
      if (stackTrace != null) {
        CustomTrace customTrace = CustomTrace(stackTrace);
        print(
            '[$type] ${customTrace.fileName}:(${customTrace.lineNumber}) - $message');
      } else {
        print('[$type] $message');
      }
      return true;
    }());
  }
}

class CustomTrace {
  final StackTrace _trace;

  String fileName;
  int lineNumber;
  int columnNumber;

  CustomTrace(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    var traceString = this._trace.toString().split("\n")[0];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    var listOfInfos = fileInfo.split(":");
    this.fileName = listOfInfos[0];
    this.lineNumber = int.parse(listOfInfos[1]);
    var columnStr = listOfInfos[2];
    columnStr = columnStr.replaceFirst(")", "");
    this.columnNumber = int.parse(columnStr);
  }
}