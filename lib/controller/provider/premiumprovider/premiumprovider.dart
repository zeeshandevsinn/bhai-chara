import 'package:flutter/material.dart';

class Premiumprovider extends ChangeNotifier {
  bool _isFreeExpanded = false;
  bool _isPremiumExpanded = false;

  get isFreeExpanded => _isFreeExpanded;
  get isPremiumExpanded => _isPremiumExpanded;

  setisPremiumExpanded(bool value) {
    _isPremiumExpanded = value;
    notifyListeners();
  }

  setisFreeExpanded(bool value) {
    _isFreeExpanded = value;
    notifyListeners();
  }
}
