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
}