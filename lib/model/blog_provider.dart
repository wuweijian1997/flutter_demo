import 'package:flutter/material.dart';

class BlogProvider with ChangeNotifier{
  Blog _blog;

  Blog get blog => _blog;

  set blog(Blog value) {
    _blog = value;
    notifyListeners();
  }

  blogLike() {
    _blog.like++;
    notifyListeners();
  }
}

class Blog {
  String title;
  int like;
  String content;

  Blog({this.title, this.like, this.content});
}