import 'dart:developer';

import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
import 'package:bhai_chara/controller/services/shared_prefrences.dart';
import 'package:bhai_chara/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/push.dart';
import '../../../utils/showSnack.dart';
import '../../../view/authentication/signup_screen_by_phone.dart';
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

  Future forgotPassword({required String email, context}) async {
    try {
      isLoading = true;
      notifyListeners();
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      await firebaseAuth.sendPasswordResetEmail(email: email);
      showSnack(context: context, text: "Check your mail to reset password");
      isLoading = false;
      notifyListeners();
      pop(context);
    } on FirebaseAuthException catch (err) {
      isLoading = false;
      notifyListeners();
      //  throw Exception(err.message.toString());
      showSnack(context: context, text: err.toString());
    } catch (err) {
      isLoading = false;
      notifyListeners();
      //  throw Exception(err.toString());
      showSnack(context: context, text: err.toString());
    }
  }

  Future<void> signInWithGoogleAccount(context,lat,long) async {
    try {
      // if (GoogleSignIn().currentUser != null) {
      await GoogleSignIn().signOut();
    // }

      isLoading = true;
      notifyListeners();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
log(" ${credential.accessToken}");
      if (credential.accessToken != null) {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        log("credential is ${userCredential.user}");
        User? user = userCredential.user;
        var data = await FirebaseManager.signUpFirebaseStoreage(
            context: context,
            name: user?.displayName,
            email: user?.email,
            image: user?.photoURL,
            password: '',
            uid: user?.uid,
            isEmailVerified: user?.emailVerified,
            isPhoneVerify: false,
            lat: lat,
            long: long
            );
        UID_Provider.uid = user?.uid.toString();
        log('google auth uid is ==>>> ${UID_Provider.uid}');
        var userData = await firebaseGetUserDetail(UID_Provider.uid);
        await _sharedPrefHelper.insertUser(userData!);
        if (user != null) {
        showSnack(context: context, text: "SignUp SuccessFully");
        pushUntil(context, RootScreen());
        
      }
      } else {
        showSnack(context: context, text: "Try again");
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log("exception is ${e.toString()}");
      showSnack(context: context, text: e.toString());
    }
  }
}
