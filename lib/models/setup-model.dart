import 'package:flutter/material.dart';

class SetupModel extends ChangeNotifier {
  String name = "";
  String key = "";

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setKey(String key) {
    this.key = key;
    notifyListeners();
  }
}