
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../view/authentication/otp_code_screen.dart';
import '../../provider/phone_number.dart';
import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../view/authentication/location.dart';
import '../../../view/authentication/signup_screen_by_phone.dart';

class SignUpProvider extends ChangeNotifier {
  bool isLoading = false;
  String PhoneNumber = "";
  String verifiedID = "";
  String OTPCode = "";
  var user;
  SignUpFirebase(context, name, email, password,
      {isEmailVerified = false, isPhoneVerified = false}) async {
    try {
      // debugger();
      isLoading = true;
      notifyListeners();
      // ignore: unused_local_variable
      user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var uid = FirebaseAuth.instance.currentUser!.uid;
      // isEmailVerified = true;
      var data = await FirebaseManager.SignUpFirebaseStoreage(context, name,
          email, password, uid, isEmailVerified, isPhoneVerified);
      isLoading = false;
      notifyListeners();
      UID_Provider.uid = uid.toString();
      // debugger();/
      print(UID_Provider.uid);

      if (user != null) {
        showSnack(context: context, text: "SignUp SuccessFully");
        pushUntil(context, SignUpScreenByPhone());
        return data;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showSnack(
          context: context,
          text: "The email address is already in use by another account.");
    }
  }

  PhoneVerifyFireBase(context, phoneNumber) async {
    try {
      isLoading = true;
      notifyListeners();

      var users =  await FirebaseFirestore.instance.collection(USER_COLLECTION).where("phoneNumber", isEqualTo: phoneNumber).get();

      if(users.docs.isEmpty){

    await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {
            FirebaseManager.verifyId = verificationId;
            verifiedID = FirebaseManager.verifyId;
             showSnack(context: context, text: "OTP Sent");
        PhoneNumber = phoneNumber.toString();
           isLoading = false;
      notifyListeners();
        push(
                                context,
                                OTPScreen(
                                  phone: PhoneProvider.phonenumber,
                                ));
            // debugger();
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
      
    
      }else{
           isLoading = false;
      notifyListeners();
        showSnack(context: context, text: "Phone Number Already Exist. Please use another Number");
      }

   
    } catch (e) {
         isLoading = false;
      notifyListeners();
      showSnack(context: context, text: "Error! Something went wrong");
    }
  }

  OTPVerify(context, String Otp, phoneNumber) async {
    try {
      isLoading = true;
      notifyListeners();
      // debugger();
      print(Otp);
      var isVerified = await FirebaseManager.VerifyOTP(verifiedID, Otp);
      // debugger();
      if (isVerified) {
        String? uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid != null) {
          FirebaseFirestore.instance
              .collection(USER_COLLECTION)
              .doc(uid)
              .update({"isPhoneVerified": true, "phoneNumber": phoneNumber});
          pushUntil(context, const LocationScreen());
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      showSnack(context: context, text: e.toString());
    }
  }
}
