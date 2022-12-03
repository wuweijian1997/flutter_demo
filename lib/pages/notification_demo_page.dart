import 'package:flutter/material.dart';

class NotificationDemoPage extends StatelessWidget {
  static const String rName = 'NotificationDemo';

  const NotificationDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NotificationListener<_TestNotification>(
          ///返回true取消冒泡,返回false继续像父节点传递.
          onNotification: (_TestNotification notification) {
            print(notification.value);
            return false;
          },
          child: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => _TestNotification('Hello World').dispatch(context),
                child: const Text('Notification'),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TestNotification extends Notification {
  final String value;

  _TestNotification(this.value);
}
