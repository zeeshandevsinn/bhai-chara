// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:bhai_chara/controller/services/shared_prefrences.dart';
import 'package:bhai_chara/view/home-screens/root_screen.dart';
import 'package:bhai_chara/view/onboard_screens/intro_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/push.dart';
import '../../utils/text-styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPreferenceHelper _sharedPrefHelper =
      SharedPreferenceHelper.instance();
  
  startTimer() async {
    var _duration = const Duration(seconds: 5);
    return Timer(_duration, Navigation);
  }

  Navigation() {
    var user = _sharedPrefHelper.isUserLoggedIn;
    if (user == true) {
      pushUntil(context, RootScreen());
    } else {
      pushUntil(context, IntroSlider());
    }
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.App,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/images/image.png"),
                height: 150,
                width: 175,
              ),
              Text(
                "BHAI CHARA",
                style: AppTextStyles.textStyleBoldBodyMedium
                    .copyWith(color: AppColors.blue),
              ),
              Text(
                "STRONGER TOGETHER",
                style: AppTextStyles.textStyleNormalBodyXSmall
                    .copyWith(color: AppColors.blue),
              )
            ],
          ),
        ));
  }
}
