import 'package:flutter/material.dart';

class ScrollNotificationListener extends StatefulWidget {
  const ScrollNotificationListener({
    Key? key,
    this.onFocus,
    required this.child,
    this.onNotification,
  }):super(key: key);

  final Widget child;
  final NotificationListenerCallback<ScrollNotification>? onNotification;
  final ValueChanged<bool>? onFocus;

  @override
  _ScrollNotificationListenerState createState() =>
      _ScrollNotificationListenerState();
}

class _ScrollNotificationListenerState
    extends State<ScrollNotificationListener> {
  bool _focusState = false;

  set _focus(bool focus) {
    _focusState = focus;
    widget.onFocus?.call(_focusState);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        widget.onNotification?.call(notification);
        _handleScrollNotification(notification);
        return false;
      },
      child: widget.child,
    );
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification &&
        notification.dragDetails != null) {
      _focus = true;
    } else if (notification is ScrollUpdateNotification &&
        _focusState == true &&
        notification.dragDetails == null) {
      _focus = false;
    } else if (notification is ScrollEndNotification && _focusState == true) {
      _focus = false;
    }
  }
}
