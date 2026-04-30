import 'dart:developer';
import 'package:bhai_chara/controller/services/shared_prefrences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  final SharedPreferenceHelper _sharedPrefHelper =
      SharedPreferenceHelper.instance();

  signUpFirebase(context, name, email, password,
      {isEmailVerified = false, isPhoneVerified = false, lat, long}) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();

    log(lat.toString());
    try {
      isLoading = true;
      notifyListeners();
      // ignore: unused_local_variable
      user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var uid = FirebaseAuth.instance.currentUser!.uid;
      var data = await FirebaseManager.signUpFirebaseStoreage(
        context: context,
        name: name,
        email: email,
        password: password,
        uid: uid,
        isEmailVerified: isEmailVerified,
        isPhoneVerify: isPhoneVerified,
        lat: lat,
        long: long,
        fcmToken: fcmToken,
      );
      isLoading = false;
      notifyListeners();
      UID_Provider.uid = uid.toString();
      var userData = await firebaseGetUserDetail(UID_Provider.uid);
      await _sharedPrefHelper.insertUser(userData!);

      print(UID_Provider.uid);
      log(user.toString());
      if (user != null) {
        showSnack(context: context, text: "SignUp SuccessFully");
        pushUntil(
            context,
            SignUpScreenByPhone(
              userid: uid.toString(),
            ));
        return data;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
      showSnack(context: context, text: e.message);
    }
  }

  phoneVerifyFireBase(context, phoneNumber, currentuserid) async {
  try {
    print(currentuserid);
    isLoading = true;
    notifyListeners();

    var users = await FirebaseFirestore.instance
        .collection('Client')
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();

    if (users.docs.isNotEmpty) {
      isLoading = false;
      notifyListeners();
      showSnack(
        context: context,
        text: "Phone Number Already Exist. Please use another Number",
      );
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      verificationCompleted: (PhoneAuthCredential credential) {
        isLoading = false;
        notifyListeners();
      },

      verificationFailed: (FirebaseAuthException e) {
        isLoading = false;
        notifyListeners();
        showSnack(context: context, text: e.message ?? "Verification failed");
      },

      codeSent: (String verificationId, int? resendToken) {
        FirebaseManager.verifyId = verificationId;
        verifiedID = verificationId;

        showSnack(context: context, text: "OTP Sent");

        isLoading = false;
        notifyListeners();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              phone: phoneNumber,
              currentuserId: currentuserid,
            ),
          ),
        );
      },

      codeAutoRetrievalTimeout: (String verificationId) {
        isLoading = false;
        notifyListeners();
        showSnack(context: context, text: "OTP request timed out");
      },
    );
  } catch (e) {
    isLoading = false;
    notifyListeners();
    showSnack(context: context, text: "Error! Something went wrong");
  }
}


  // phoneVerifyFireBase(context, phoneNumber, currentuserid) async {
  //   try {
  //     print(currentuserid);
  //     isLoading = true;
  //     notifyListeners();

  //     var users = await FirebaseFirestore.instance
  //         .collection('Client')
  //         .where("phoneNumber", isEqualTo: phoneNumber)
  //         .get();
  //     // isLoading = false;
  //     // notifyListeners();
  //     if (users.docs.isNotEmpty) {
  //       isLoading = false;
  //       notifyListeners();
  //       showSnack(
  //           context: context,
  //           text: "Phone Number Already Exist. Please use another Number");
  //     } else {
  //       await FirebaseAuth.instance.verifyPhoneNumber(
  //           phoneNumber: phoneNumber,
  //           verificationCompleted: (PhoneAuthCredential credential) {},
  //           verificationFailed: (FirebaseAuthException e) {},
  //           codeSent: (String verificationId, int? resendToken) {
  //             FirebaseManager.verifyId = verificationId;
  //             verifiedID = FirebaseManager.verifyId;
  //             showSnack(context: context, text: "OTP Sent");
  //             PhoneNumber = phoneNumber.toString();

  //             isLoading = false;
  //             notifyListeners();

  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => OTPScreen(
  //                           phone: phoneNumber,
  //                           currentuserId: currentuserid,
  //                         )));
  //             //  push(
  //             //     context,
  //             //     OTPScreen(
  //             //       phone: PhoneProvider.phonenumber,
  //             //     )
  //             //     );
  //             // debugger();
  //           },
  //           codeAutoRetrievalTimeout: (String verificationId) {});
  //     }
  //   } catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     showSnack(context: context, text: "Error! Something went wrong");
  //   }
  // }

  otpverify(context, String Otp, phoneNumber, uid) async {
    try {
      isLoading = true;
      notifyListeners();
      // debugger();
      print(Otp);
      var isVerified = await FirebaseManager.VerifyOTP(verifiedID, Otp);
      // debugger();
      if (isVerified) {
        // String? uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid != null) {
          print(phoneNumber);
          await FirebaseFirestore.instance
              .collection(USER_COLLECTION)
              .doc(uid)
              .set({
            "isPhoneVerified": true,
            "phoneNumber": phoneNumber,
          }, SetOptions(merge: true));

          // FirebaseFirestore.instance
          //     .collection(USER_COLLECTION)
          //     .doc(uid)
          //     .update({"isPhoneVerified": true, "phoneNumber": phoneNumber});
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
