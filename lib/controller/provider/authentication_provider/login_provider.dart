



import 'dart:developer';

import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
import 'package:bhai_chara/controller/services/shared_prefrences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/push.dart';
import '../../../utils/showSnack.dart';
import '../../../view/home-screens/root_screen.dart';
import '../phone_number.dart';

class LoginProvider extends ChangeNotifier {
  final SharedPreferenceHelper _sharedPrefHelper =
      SharedPreferenceHelper.instance();
  bool isLoading = false;
  Login(context, emailController, passwordController) async {
    try {
      isLoading = true;
      notifyListeners();
// debugger();
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      // ignore: unused_local_variable
      var uid = await firebaseAuth.signInWithEmailAndPassword(
          email: emailController, password: passwordController);
      // debugger();
      UID_Provider.uid = await FirebaseAuth.instance.currentUser!.uid;
      // Fetch user data from Firebase
      var userData = await firebaseGetUserDetail(UID_Provider.uid);
      await _sharedPrefHelper.insertUser(userData!);
      isLoading = false;
      notifyListeners();
      showSnack(context: context, text: "SignIn Successfully");
      FocusScope.of(context).nextFocus();
      pushUntil(context, RootScreen());
      // ignore: unused_catch_clause
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showSnack(context: context, text: e.toString());
    }
  }
}
