import 'package:flutter/material.dart';

abstract class FlashlightDelegate {
  const FlashlightDelegate();

  void paint(Canvas canvas, Offset touchOffset);
}
