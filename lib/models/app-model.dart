import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'otp-model.dart';

class AppModel extends ChangeNotifier {

  AppModel() {
    new Timer.periodic(new Duration(milliseconds:100), (Timer t) => updateOTP());
    _getData();
  }

  List<OTPModel> otpList = [];

  void _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();

    for (int i = 0; i < keys.length; i++) {
      var k = keys.elementAt(i);
      String value = prefs.get(k); 
      var splitedValue = value.split("@"); 
      if (splitedValue.length == 3) {
        var newOTP = new OTPModel(splitedValue[0], splitedValue[1], int.parse(splitedValue[2]));
        newOTP.uuid = k;
        newOTP.refresh(newOTP.lastCounter);
        otpList.add(newOTP);
      }
    }
    notifyListeners();
  }

  void updateOTP() {
    for (int i = 0; i < otpList.length; i++) {
      var _currentCounterInDouble = ((DateTime.now().millisecondsSinceEpoch) / (1000 * otpList[i].interval));
      var _currentCounter = _currentCounterInDouble.floor();
      otpList[i].progress = _currentCounterInDouble - _currentCounter.toDouble();
      if (_currentCounter != otpList[i].lastCounter) {
        otpList[i].refresh(_currentCounter);
        otpList[i].lastCounter = _currentCounter;
        otpList[i].progress = 0;
      }
    }

    notifyListeners();
  }

  void addOTP(String name, String key, int interval) async {
    var newOTP = new OTPModel(name, key, interval);
    newOTP.refresh(newOTP.lastCounter);
    otpList.add(newOTP);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(newOTP.uuid, name + '@' + key + "@" + interval.toString());

    notifyListeners();
  }

  void deleteOTP(String uuid) async {
    otpList.removeWhere((otp) => otp.uuid == uuid);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(uuid);

    notifyListeners();
  }
}