import 'package:flutter/material.dart';

class CloneListItemModel {
  CloneListItemModel({this.title, this.onPress});

  String title;
  VoidCallback onPress;
}