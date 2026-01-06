import 'package:flutter/material.dart';

class SellScreenProvider extends ChangeNotifier {
  bool _selected = false;
  bool _isTextFieldEmpty = true;

  final TextEditingController otherController = TextEditingController();

  bool get selected => _selected;
  bool get isTextFieldEmpty => _isTextFieldEmpty;

  SellScreenProvider() {
    otherController.addListener(_textListener);
  }

  void _textListener() {
    _isTextFieldEmpty = otherController.text.isEmpty;
    notifyListeners();
  }

  void toggleTextFieldVisibility() {
    _selected = !_selected;
    notifyListeners();
  }

  void clearText() {
    otherController.clear();
    _isTextFieldEmpty = true;
    notifyListeners();
  }

  @override
  void dispose() {
    otherController.dispose();
    super.dispose();
  }
}
