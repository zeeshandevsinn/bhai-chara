import 'dart:convert';
import 'dart:developer';

import 'package:bhai_chara/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _sharedPreferences;

class SharedPreferenceHelper {
  static const String _USER = 'SharedPreferenceHelper.user';
  static const String _IS_SIGN_UP_PROFILE_COMPLETE = 'SharedPreferenceHelper.is_sign_up_profile_complete';
  static const String _CURRENT_NOTIFICATION_PAYLOAD = 'SharedPreferenceHelper.current_notification_payload';
  static const String _IS_USER_APP_FOREGROUND = 'SharedPreferenceHelper.is_user_app_in_foreground';
  static SharedPreferenceHelper? _instance;
  SharedPreferenceHelper._();

  static SharedPreferenceHelper instance() {
    _instance ??= SharedPreferenceHelper._();
    return _instance!;
  }

  static Future<void> initializeSharedPreferences() async => _sharedPreferences = await SharedPreferences.getInstance();
  set isSignupComplete(bool value) => _sharedPreferences?.setBool(_IS_SIGN_UP_PROFILE_COMPLETE, value);
  Future<String?> get notificationPayload async {
    await _sharedPreferences?.reload();
    final payload = _sharedPreferences?.getString(_CURRENT_NOTIFICATION_PAYLOAD);
    if (payload != null && payload.isNotEmpty) {
      await _sharedPreferences?.reload();
      _sharedPreferences?.setString(_CURRENT_NOTIFICATION_PAYLOAD, payload);
    }
    return payload;
  }

  Future<bool> get isAppInForeground async {
    await _sharedPreferences?.reload();
    return _sharedPreferences?.getBool(_IS_USER_APP_FOREGROUND) ?? false;
  }
  bool get isSignupComplete => _sharedPreferences?.getBool(_IS_SIGN_UP_PROFILE_COMPLETE) ?? false;
  bool get isUserLoggedIn => _sharedPreferences?.containsKey(_USER) ?? false;
  Future<UserModel?>  user() async {
    final userSerialization = _sharedPreferences?.getString(_USER);
    if (userSerialization == null) return null;
    try {
      return UserModel.fromJson(json.decode(userSerialization));
    } catch (_) {
      return null;
    }
  }

  Future<void> insertUser(UserModel response) async {
    log("SAVE IN CACHE");
    final userSerialization = json.encode(response.toJson());
log(userSerialization.toString());
    _sharedPreferences?.setString(_USER, userSerialization);
    log("added key");
  }

  Future<void> updateIsAppInForeground(bool value) async {
    await _sharedPreferences?.reload();
    _sharedPreferences?.setBool(_IS_USER_APP_FOREGROUND, value);
  }

  Future<void> clear() async => _sharedPreferences?.clear();
}
