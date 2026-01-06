// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:bhai_chara/common/custom_button.dart';
import 'package:bhai_chara/common/custom_container_tile.dart';
import 'package:bhai_chara/controller/provider/authentication_provider/login_provider.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/view/authentication/forget_password.dart';
import 'package:bhai_chara/view/authentication/signup_screen.dart';
import 'package:bhai_chara/view/onboard_screens/onboard_screen_three.dart';
import 'package:bhai_chara/view/settings-screens/privacy_policy.dart';
import 'package:bhai_chara/view/settings-screens/terms_conditions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/authentication_provider/variable.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Position? location;
  var x = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        var pro = context.watch<LoginProvider>();
        pro.isLoading = false;
        return push(context, const OnboardScreenThree());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Builder(builder: (context) {
          var pro = context.watch<LoginProvider>();
          return pro.isLoading
              ? const Center(
                  child: CustomLoader(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // CustomContainer(
                        //   text: "Login",
                        //   iconVar: null,
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            height: 130,
                            width: 150,
                            decoration: const BoxDecoration(
                                // color: AppColors.primary,
                                image: DecorationImage(
                                    image: AssetImage("assets/images/logo.png"),
                                    fit: BoxFit.contain)),
                          ),
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
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hello there, login in to continue!",
                          style: AppTextStyles.textStyleBoldXLBodySmall,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          obsecuretext: false,
                          width: size.width * .90,
                          controller: emailController,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labeltext: "Email Address",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Consumer<VariableProvider>(
                          builder: (context, value, _) {
                            return CustomTextField(
                              obsecuretext: value.x % 2 == 0 ? false : true,
                              // height: 30,
                              width: size.width * .90,
                              controller: passwordController,
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labeltext: "Password",
                              suffixIcon: value.x % 2 != 0
                                  ? IconButton(
                                      onPressed: () {
                                        // setState(() {});

                                        // x = VariableProvider.IncrementVariable(
                                        //     x);
                                             double values =
                                                value.setIncrement(value.x);
                                            value.setincrementX(values);
                                      },
                                      icon: const Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        // setState(() {});
                                        // x = VariableProvider.IncrementVariable(
                                        //     x);
                                             double values =
                                                value.setIncrement(value.x);
                                            value.setincrementX(values);
                                      },
                                      icon: const Icon(
                                        Icons.visibility,
                                        size: 20,
                                      )),
                              suffixIconColor: AppColors.grey,
                            );
                          },
                        ),

                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  push(context, const ForgetScreen());
                                },
                                child: const Text("Forget Password"))),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                          onTap: () async {
                            if (emailController.text.isEmpty) {
                              showSnack(
                                  context: context, text: "Please Enter Email");
                            } else if (!emailController.text.contains('@') &&
                                !emailController.text.contains('.com')) {
                              showSnack(
                                  context: context,
                                  text: "Enter Please Correct Email");
                            } else if (passwordController.text.isEmpty) {
                              showSnack(
                                  context: context,
                                  text: "Please Enter Password");
                            } else if (passwordController.text.length <= 5) {
                              showSnack(
                                  context: context, text: "Invalid Password");
                            } else {
                              var pro = context.read<LoginProvider>();
                              await pro.login(context, emailController.text,
                                  passwordController.text);
                            }
                          },
                          text: "Continue",
                          width: size.width * .90,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: AppTextStyles.textStyleSubtitleBody,
                            ),
                            TextButton(
                              onPressed: () {
                                push(context, const SignUpScreen());
                              },
                              child: Text(
                                "Sign up",
                                style: AppTextStyles.textStyleSubtitleBody
                                    .copyWith(color: AppColors.blue),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 3, left: 3),
                              height: 2,
                              width: size.width * .30,
                              color: AppColors.light_black,
                            ),
                            Text(
                              "OR",
                              style: AppTextStyles.textStyleSubtitleBody,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 3, right: 3),
                              height: 2,
                              width: size.width * .30,
                              color: AppColors.light_black,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomContainerTile(
                          width: size.width * .85,
                          image: "assets/images/google.png",
                          text: "Continue with Google",
                          style_text:
                              AppTextStyles.textStyleNormalBoldXLBodySmall,
                          ontap: () {
                            Future.delayed(const Duration(microseconds: 200))
                                .then((value) async {
                              final permissionStatus =
                                  await Geolocator.checkPermission();
                              if (permissionStatus ==
                                  LocationPermission.denied) {
                                _handleDeniedLocationPermissionScenarios();
                              } else if (permissionStatus ==
                                  LocationPermission.deniedForever) {
                                _showLocationDeniedForeverSnackbar();
                              } else {
                                enableLocationPermission();
                                final isLocationServiceEnabled =
                                    await Geolocator.isLocationServiceEnabled();
                                if (isLocationServiceEnabled) {
                                  location =
                                      await Geolocator.getCurrentPosition();
                                  // Handle the received location data

                                  if (!mounted) return;
                                  pro.signInWithGoogleAccount(context,
                                      location!.latitude, location!.longitude);

                                  // handleLocation(await Geolocator.getCurrentPosition());

                                  return;
                                }
                                _handleEnableLocationScenarios();
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
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
                                      push(context,
                                          const TermsAndConditionsScreen());
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
                );
        }),
      ),
    );
  }

  bool? isHaveLocationPermission = false;
  void _handleEnableLocationScenarios() async {
    final requestServiceRequestValue =
        await Geolocator.isLocationServiceEnabled();
    if (!requestServiceRequestValue) {}
    location = await Geolocator.getCurrentPosition();
    if (!mounted) return;
    var pro = context.watch<LoginProvider>();
    pro.signInWithGoogleAccount(
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
// Time: 0s - User on Screen A, taps "Load Data"
// Time: 1s - Async operation starts (API call)
// Time: 2s - User gets impatient, goes to Screen B
// Time: 3s - Screen A gets destroyed
// Time: 4s - API call finally returns with data
// Time: 4s - Check: if (!mounted) return; ✅
// Time: 4s - Stop! Don't try to update dead widget
        var pro = context.watch<LoginProvider>();
        pro.signInWithGoogleAccount(
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
