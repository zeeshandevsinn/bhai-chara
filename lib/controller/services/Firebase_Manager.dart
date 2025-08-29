// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable, unused_field, unnecessary_null_comparison

import 'dart:developer';

import 'dart:io';

// import 'dart:js_interop';
import 'package:bhai_chara/model/user_model.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../model/product_detail_model.dart';

const USER_COLLECTION = "Client";
const CHAT_COLLECTION = "chat";
const REQUEST_COLLECTION = "requests";
const PRODUCT_COLLECTION = "Products";
const Favourites = "favourites";

class FirebaseManager {
  static final _auth = FirebaseAuth.instance;
  static String verifyId = '';
  static String code = '';
// /////////////////////DELETE ACCOUNT ////////////////////////

  // 

  static Future<void> deleteAccount(String email, String password) async {
    try {
      // Reauthenticate the user
      User user = FirebaseAuth.instance.currentUser!;
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      await FirebaseFirestore.instance
          .collection('Client')
          .doc(user.uid)
          .delete();
      // Delete the user account
      await user.delete();

      print('User account deleted successfully');
    } catch (e) {
      print('Error deleting user account: $e');
      throw e;
    }
  }

///////////////// UPDATE PROFILE DATA /////////////////////////
  static Future<Map<String, dynamic>> updateProfile({
    required String uid,
    String? name,
    String? email,
    File? profileImage,
    String? fcmtoken,
  }) async {
    try {
      // Create a map to hold the updated user data
      Map<String, dynamic> userData = {};

      // Add fields to update if not null
      if (name != null) {
        userData['Name'] = name;
      }
      if (email != null) {
        userData['Email'] = email;
      }

      if (fcmtoken != null) {
        userData['fcm_token'] = fcmtoken;
      }
      // Upload profile image if provided
      if (profileImage != null) {
        String imageUrl = await uploadProfileImage(profileImage);
        userData['image'] = imageUrl;
      }

      // Update user data in Firestore
      await FirebaseFirestore.instance
          .collection(USER_COLLECTION)
          .doc(uid)
          .update(userData);

      // Fetch and return the updated user data
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(USER_COLLECTION)
          .doc(uid)
          .get();

      Map<String, dynamic>? updatedUserData =
          snapshot.data() as Map<String, dynamic>? ?? {};

      return updatedUserData;
    } catch (e) {
      print('Error updating profile: $e');
      // Handle error
      rethrow; // Re-throw the error to be caught by the caller
    }
  }

  static Future<String> uploadProfileImage(File imageFile) async {
    try {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');
      Reference referenceImageToUpload =
          referenceDirImages.child(uniqueFileName);

      await referenceImageToUpload.putFile(imageFile);

      String downloadUrl = await referenceImageToUpload.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      throw e;
    }
  }

  static addProduct(
      {price,
      age,
      title,
      description,
      category,
      uid,
      subcategory,
      List<String>? urlImage,
      isFree,
      datetime}) async {
    try {
      var data = await FirebaseFirestore.instance.collection("Products").add({
        "price": price,
        "age": age,
        "title": title,
        "description": description,
        "category": category,
        "subcategory": subcategory,
        "urlImage": urlImage,
        "isFree": isFree,
        "Time": datetime,
        "uid": uid
      });
      return data;
    } catch (e) {
      debugger();
      showSnack(text: e.toString());
    }
  }

  static AddImages(List<File> selectedimages,
      {price,
      title,
      age,
      description,
      category,
      subcategory,
      uid,
      isFree,
      datetime}) async {
    try {
      List<String> urlImage = [];

      Future<void> uploadImages(List<File> selectedImages) async {
        for (var i = 0; i < selectedImages.length; i++) {
          String uniqueFileName =
              DateTime.now().millisecondsSinceEpoch.toString();
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot.child('images');
          Reference referenceImageToUpload =
              referenceDirImages.child(uniqueFileName);

          await referenceImageToUpload.putFile(File(selectedImages[i].path));

          String downloadUrl = await referenceImageToUpload.getDownloadURL();
          urlImage.add(downloadUrl);
        }
      }

// Call the function with your selecuted images list
      await uploadImages(selectedimages);

      // List<String> urlImage = [];
      // Reference referenceRoot = FirebaseStorage.instance.ref();
      // // ignore: unused_local_variable
      // Reference referenceDirImages = referenceRoot.child('images');
      // for (var i = 0; i < selectedimages.length; i++) {
      //   String uniqueFileName =
      //       DateTime.now().millisecondsSinceEpoch.toString();
      //   Reference referenceRoot = FirebaseStorage.instance.ref();
      //   Reference referenceDirImages = referenceRoot.child('images');
      //   Reference referenceImageToUpload =
      //       referenceDirImages.child(uniqueFileName);
      //   referenceImageToUpload.putFile(File(selectedimages[i].path));
      //   urlImage.add(await referenceImageToUpload.getDownloadURL());
      // }
      await addProduct(
          urlImage: urlImage,
          price: price,
          age: age,
          title: title,
          description: description,
          category: category,
          subcategory: subcategory,
          uid: uid,
          isFree: isFree,
          datetime: datetime);
    } catch (e) {
      // showSnack(text: e.toString());
      return null;
    }
  }

  static signUpFirebaseStoreage({
    context,
    name,
    email,
    password,
    uid,
    isEmailVerified,
    isPhoneVerify,
    image,
    lat,
    long,
    fcmToken,
  }) async {
    try {
      var data =
          await FirebaseFirestore.instance.collection("Client").doc(uid).set({
        "Name": name,
        "Email": email,
        "Password": password,
        "image": image ?? "",
        "UID": uid.toString(),
        "isEmailVerified": isEmailVerified,
        "isPhoneVerified": isPhoneVerify,
        "createdTime": DateTime.now().toString(),
        "latitude": lat,
        "longitude": long,
        "fcm_token": fcmToken
      }, SetOptions(merge: true));
      return data;
    } catch (e) {
      debugger();
      showSnack(text: e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  static VerifyOTP(String verificationID, String OTP) async {
    // try {
    //   var credentials = await _auth.signInWithCredential(
    //       PhoneAuthProvider.credential(
    //           verificationId: verifyId, smsCode: code));
    //   return credentials;
    // } catch (e) {
    //   print("Firebase Auth Error: $e");
    // }
    // debugger();
    String otp = OTP.trim();
    if (otp.isNotEmpty) {
      try {
        // Use the Firebase Auth instance to sign in with the OTP
        AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID,
          smsCode: otp,
        );

        // If verification is successful, you can access the user information

        return true;
        // Now, you can navigate to the next screen or perform other actions
      } catch (e) {
        print('Error verifying OTP: $e');
        // Handle the error, e.g., show an error message
      }
    } else {
      // Display an error message for an empty OTP
      print('Please enter the OTP');
    }
  }
}
// }

Future<UserModel?> firebaseGetUserDetail(uid) async {
  try {
    var data = await FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc(uid)
        .get();
    // debugger();
    if (data != null) {
      print(data.data());
      return UserModel.fromJson(data.data()!);
    }
  } catch (e) {
    log("exception is ===> ${e}");
  }
}
