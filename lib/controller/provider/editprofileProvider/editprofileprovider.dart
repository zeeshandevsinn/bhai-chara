import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../main.dart';
import '../../../model/user_model.dart';
import '../../../utils/showSnack.dart';
import '../../services/Firebase_Manager.dart';
import '../../services/shared_prefrences.dart';

class ProfileEditProvider with ChangeNotifier {
  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper.instance();

  File? _profilePic;
  bool _isLoading = false;

  File? get profilePic => _profilePic;
  bool get isLoading => _isLoading;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void initData(UserModel user) {
    fullNameController.text = user.name ?? '';
    emailController.text = user.email ?? '';
  }

  Future<void> pickProfilePhoto() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _profilePic = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> updateUserProfile(BuildContext context, UserModel user) async {
    if (fullNameController.text.isEmpty) {
      showSnack(context: context, text: "Please Enter Full Name");
      return;
    }
    if (emailController.text.isEmpty) {
      showSnack(context: context, text: "Please Enter Email");
      return;
    }
    if (!emailController.text.contains('@') &&
        !emailController.text.contains('.com')) {
      showSnack(context: context, text: "Please Enter Correct Email");
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      Map<String, dynamic> updatedUserData =
          await FirebaseManager.updateProfile(
        uid: user.uID!,
        name: fullNameController.text,
        email: emailController.text,
        profileImage: _profilePic,
      );

      UserModel updatedUser = UserModel.fromJson(updatedUserData);
      await _sharedPreferenceHelper.insertUser(updatedUser);

      _isLoading = false;
      notifyListeners();
      if (navigatorKey.currentContext != null) {
        showSnack(
          context: navigatorKey.currentContext!,
          text: "Profile Updated Successfully",
        );
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      showSnack(context: context, text: "Error: $e");
    }
  }
}
