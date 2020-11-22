import 'package:demo/model/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ClippingSlideStatusListener = void Function(SlideStatus status);

mixin ClippingSlideStatusListenerMixin {
  final ObserverList<ClippingSlideStatusListener> _statusListeners = ObserverList<ClippingSlideStatusListener>();

  /*void didRegisterListener();

  void didUnregisterListener();*/

  void addStatusListener(ClippingSlideStatusListener listener) {
    // didRegisterListener();
    _statusListeners.add(listener);
  }

  void removeStatusListener(ClippingSlideStatusListener listener) {
    final bool removed = _statusListeners.remove(listener);
    if (removed) {
      // didUnregisterListener();
    }
  }

  void notifyStatusListeners(SlideStatus status) {
    final List<ClippingSlideStatusListener> localListeners = List<ClippingSlideStatusListener>.from(_statusListeners);
    for (final ClippingSlideStatusListener listener in localListeners) {
      try {
        if (_statusListeners.contains(listener))
          listener(status);
      } catch (exception, stack) {
        InformationCollector collector;
        FlutterError.reportError(FlutterErrorDetails(
            exception: exception,
            stack: stack,
            library: 'animation library',
            context: ErrorDescription('while notifying status listeners for $runtimeType'),
            informationCollector: collector
        ));
      }
    }
  }
}
