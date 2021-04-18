import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'otp-model.dart';

class AppModel extends ChangeNotifier {

  AppModel() {
    new Timer.periodic(new Duration(milliseconds:100), (Timer t) => updateOTP());
   // otpList.add(new OTPModel("Test", "ABCDEFGHIKLMNOPQ"));
   // otpList.add(new OTPModel("Test 1234", "ABCDEFGHIKLMNOPQ"));
    _getData();
  }

  List<OTPModel> otpList = [];
  double progress = 0;

  int _lastCounter = 0;

  void _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();

    for (int i = 0; i < keys.length; i++) {
      var k = keys.elementAt(i);
      String value = prefs.get(k); 
      var splitedValue = value.split("@"); 
      if (splitedValue.length == 2) {
        var newOTP = new OTPModel(splitedValue[0], splitedValue[1]);
        newOTP.uuid = k;
        newOTP.refresh(_lastCounter);
        otpList.add(newOTP);
      }
    }
    notifyListeners();
  }

  void updateOTP() {
    var _currentCounterInDouble = ((DateTime.now().millisecondsSinceEpoch) / (1000 * 30));
    var _currentCounter = _currentCounterInDouble.floor();
    progress = _currentCounterInDouble - _currentCounter.toDouble();
    if (_currentCounter != _lastCounter) {
      otpList.forEach((otp) => otp.refresh(_currentCounter));
      _lastCounter = _currentCounter;
      progress = 0;
    }

    notifyListeners();
  }

  void addOTP(String name, String key) async {
    var newOTP = new OTPModel(name, key);
    newOTP.refresh(_lastCounter);
    otpList.add(newOTP);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(newOTP.uuid, name + '@' + key);

    notifyListeners();
  }

  void deleteOTP(String uuid) async {
    otpList.removeWhere((otp) => otp.uuid == uuid);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(uuid);

    notifyListeners();
  }
}