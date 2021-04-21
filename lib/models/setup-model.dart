import 'package:flutter/material.dart';

class SetupModel extends ChangeNotifier {
  String name = "";
  String key = "";
  int interval = 30;

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setKey(String key) {
    this.key = key;
    notifyListeners();
  }

  void setInterval(int interval) {
    this.interval = interval;
    notifyListeners();
  }
}