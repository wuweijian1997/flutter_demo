import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final VoidCallback onClick;
  final Duration delayed;
  final Widget child;

  const Button({
    required this.onClick,
    required this.child,
    this.delayed = const Duration(milliseconds: 300)
  });

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isBlock = false;

  VoidCallback get onClick => widget.onClick;

  Duration get delayed => widget.delayed;

  Widget get child => widget.child;

  throttle() {
    if (!_isBlock) {
      _isBlock = true;
      onClick.call();
      Future.delayed(delayed, () {
        _isBlock = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: throttle,
      child: child,
    );
  }
}