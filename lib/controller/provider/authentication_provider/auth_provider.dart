import 'dart:developer';

import 'package:bhai_chara/utils/preferences.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../services/Screen_Manager.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  double lats = 0.0;
  double lngs = 0.0;
  String currentAddress = "";

  // ignore: unused_field
  Position? _currentPosition;

  void setAddress(String value) {
    currentAddress = value;
    notifyListeners();
  }

  void setlatnadlng(lat, lng) {
    lats = lat;
    lngs = lng;
    notifyListeners();
  }

  Location(context) async {
    // debugger();
    try {
      isLoading = true;
      notifyListeners();

      var data = await ScreenManager.geoLocation(context);
      log('aaaaaaaaaaaaaaaaaaaaaa');

      if (data != null) {
        currentAddress = data;
        await Preferences.saveAddress(data);
        isLoading = false;
        notifyListeners();
        return currentAddress;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showSnack(
          context: context, text: "Here Have Some Problem Please Try Again");
    }
  }
}
