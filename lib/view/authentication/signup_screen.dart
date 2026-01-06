import 'dart:developer';

import 'package:bhai_chara/common/custom_container_tile.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/view/authentication/signup_screen_by_email.dart';
import 'package:bhai_chara/view/settings-screens/privacy_policy.dart';
import 'package:bhai_chara/view/settings-screens/terms_conditions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/authentication_provider/login_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Position? location;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      // backgroundColor: AppColors.primary,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        // padding: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 130,
                    width: 150,
                    decoration: const BoxDecoration(
                        // color: AppColors.primary,
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.contain)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Welcome to BHAI CHARA",
                  style: AppTextStyles.textStyleBoldBodyMedium,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: size.width * .80,
                      child: Text(
                        "Where trust unites buyers and seller in a strong community",
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.textStyleBoldXLBodySmall,
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Create your account to continue!",
                style: AppTextStyles.textStyleBoldXLBodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              // CustomContainerTile(
              //   image: "assets/images/google.png",
              //   text: "Continue with Google",
              //   style_text: AppTextStyles.textStyleNormalBoldXLBodySmall,
              //   ontap: () {
              //     Future.delayed(const Duration(microseconds: 200))
              //         .then((value) async {
              //       final permissionStatus = await Geolocator.checkPermission();
              //       if (permissionStatus == LocationPermission.denied) {
              //           _handleDeniedLocationPermissionScenarios();
              //       } else if (permissionStatus ==
              //           LocationPermission.deniedForever) {
              //         _showLocationDeniedForeverSnackbar();
              //       } else {
              //         enableLocationPermission();
              //         final isLocationServiceEnabled =
              //             await Geolocator.isLocationServiceEnabled();
              //         if (isLocationServiceEnabled) {
              //           location = await Geolocator.getCurrentPosition();
              //           // Handle the received location data
              //           context.read<LoginProvider>().signInWithGoogleAccount(
              //               context, location!.latitude, location!.longitude);

              //           // handleLocation(await Geolocator.getCurrentPosition());

              //           return;
              //         }
              //         _handleEnableLocationScenarios();
              //       }
              //     });
              //   },
              // ),
              const SizedBox(
                height: 20,
              ),
              CustomContainerTile(
                  image: "assets/images/mail.png",
                  text: "Continue with Email",
                  style_text: AppTextStyles.textStyleNormalBoldXLBodySmall,
                  ontap: () {
                    push(context, const SignupByEmail());
                  }),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: RichText(
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "BHAI CHARA ",
                        style: AppTextStyles.textStyleBoldBodyXSmall,
                      ),
                      TextSpan(
                        text: "Terms and Conditions ",
                        style: AppTextStyles
                            .textStyleNormalBody_BlueColor_Underline,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            push(context, const TermsAndConditionsScreen());
                          },
                      ),
                      TextSpan(
                        text: "and ",
                        style: AppTextStyles.textStyleBoldBodyXSmall,
                      ),
                      TextSpan(
                        text: "Privacy",
                        style: AppTextStyles
                            .textStyleNormalBody_BlueColor_Underline,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            push(context, PrivacyPolicyScreen());
                          },
                      ),
                      const TextSpan(
                        text: " ",
                      ),
                      TextSpan(
                        text: "Policy",
                        style: AppTextStyles
                            .textStyleNormalBody_BlueColor_Underline,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            push(context, PrivacyPolicyScreen());
                          },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool? isHaveLocationPermission = false;

  void _handleEnableLocationScenarios() async {
    final requestServiceRequestValue =
        await Geolocator.isLocationServiceEnabled();
    if (!requestServiceRequestValue) return;

    location = await Geolocator.getCurrentPosition();

    if (!mounted) return;
    context.read<LoginProvider>().signInWithGoogleAccount(
        context, location!.latitude, location!.longitude);
  }

  void _showLocationDeniedForeverSnackbar() =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Enable Location",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xffFFFFFF), fontSize: 14)),
            backgroundColor: Color(0xfff84a4a)),
      );

  void _handleDeniedLocationPermissionScenarios() async {
    final permissionRequestStatus = await Geolocator.requestPermission();
    if (permissionRequestStatus == LocationPermission.denied) {
    } else if (permissionRequestStatus == LocationPermission.deniedForever) {
      _showLocationDeniedForeverSnackbar();
    } else {
      enableLocationPermission();
      final isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        location = await Geolocator.getCurrentPosition();
        if (!mounted) return;
        context.read<LoginProvider>().signInWithGoogleAccount(
            context, location!.latitude, location!.longitude);
        return;
      }
      _handleEnableLocationScenarios();
    }
  }

  void enableLocationPermission() => isHaveLocationPermission = true;

  Future<void> handleLocation(Position locationPositionData) async {
    log('==================> I am now in Handle Location method of bloc${locationPositionData.latitude} ');
    await Future.delayed(const Duration(milliseconds: 1000));
  }
}
