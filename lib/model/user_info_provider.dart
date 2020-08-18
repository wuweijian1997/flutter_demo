import 'package:flutter/material.dart';

class UserInfoProvider with ChangeNotifier {
  UserInfo _userInfo = UserInfo(name: 'kafka', age: 20);

  UserInfo get userInfo => _userInfo;

  set userInfo(UserInfo value) {
    _userInfo = value;
    notifyListeners();
  }

  addAge() {
    _userInfo.age++;
    notifyListeners();
  }
}

class UserInfo {
  String name;
  int age;

  UserInfo({this.name, this.age});
}
