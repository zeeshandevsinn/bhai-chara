import 'package:flutter/material.dart';
import '../../../model/user_model.dart';
import '../../services/Firebase_Manager.dart';
import '../../services/shared_prefrences.dart';

class Amountprovider extends ChangeNotifier {
  final SharedPreferenceHelper sharedPreferenceHelper =
      SharedPreferenceHelper.instance();

  UserModel? _userData;
  bool isloading = false;

  UserModel? get userData => _userData;

  void fetchUserData() async {
    UserModel? userData = await sharedPreferenceHelper.user();
    if (userData != null) {
      _userData = userData;
      notifyListeners();
    } else {
      return _userData = null;
    }
  }

   Future<String?> deleteAccount(String email, String password) async {
    isloading = true;
    notifyListeners();

    final error =
        await FirebaseManager.deleteAccount(email, password);

    isloading = false;
    notifyListeners();

    if (error == null) {
      await sharedPreferenceHelper.clear();
    }

    return error;
  }
}

