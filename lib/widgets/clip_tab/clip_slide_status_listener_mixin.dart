import 'package:demo/model/index.dart';
import 'package:flutter/foundation.dart';

typedef ClipSlideStatusListener = void Function(SlideStatus status);

mixin ClipSlideStatusListenerMixin {
  final ObserverList<ClipSlideStatusListener> _statusListeners = ObserverList<ClipSlideStatusListener>();

  /*void didRegisterListener();

  void didUnregisterListener();*/

  void addStatusListener(ClipSlideStatusListener listener) {
    // didRegisterListener();
    _statusListeners.add(listener);
  }

  void removeStatusListener(ClipSlideStatusListener listener) {
    final bool removed = _statusListeners.remove(listener);
    if (removed) {
      // didUnregisterListener();
    }
  }

  void notifyStatusListeners(SlideStatus status) {
    final List<ClipSlideStatusListener> localListeners = List<ClipSlideStatusListener>.from(_statusListeners);
    for (final ClipSlideStatusListener listener in localListeners) {
      try {
        if (_statusListeners.contains(listener)) {
          listener(status);
        }
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
            exception: exception,
            stack: stack,
            library: 'animation library',
            context: ErrorDescription('while notifying status listeners for $runtimeType'),
        ));
      }
    }
  }
}
