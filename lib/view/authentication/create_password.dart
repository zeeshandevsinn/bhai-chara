import 'dart:async';
import 'dart:developer';

import 'package:bhai_chara/common/material_dialouge.dart';
import 'package:bhai_chara/controller/provider/authentication_provider/firebase_signup_provider.dart';
import 'package:bhai_chara/utils/app_config.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../common/custom_button.dart';
import '../../common/custom_container_tile.dart';
import '../../controller/provider/authentication_provider/variable.dart';
import '../../utils/app_colors.dart';
import '../../utils/showSnack.dart';
import '../../utils/text-styles.dart';

// ignore: must_be_immutable
class CreatePassword extends StatefulWidget {
  CreatePassword({super.key, this.emailController, this.fullName});
  var emailController, fullName;
  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  Position? location;

  var x = 1;
  var y = 1;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        var sign = context.read<SignUpProvider>();
        sign.isLoading = false;
        return pop(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Builder(builder: (context) {
          var sign = context.watch<SignUpProvider>();
          return sign.isLoading
              ? Center(child: CustomLoader())
              : ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Container(
                      height: size.height * .95,
                      width: size.width,
                      // padding: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   child:
                            Gap.h(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 130,
                                  width: 130,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/logo.png"),
                                          fit: BoxFit.contain)),
                                ),
                              ],
                            ),
                            Gap.h(50),
                            Center(
                              child: Text(
                                "Create a password",
                                style: AppTextStyles.textStyleBoldSubTitleLarge,
                              ),
                            ),
                            Gap.h(10),
                            Center(
                              child: Container(
                                  child: Text.rich(
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      TextSpan(children: [
                                        TextSpan(
                                          text:
                                              "You are creating a password for ",
                                          style: AppTextStyles
                                              .textStyleNormalBodyXSmall,
                                        ),
                                        TextSpan(
                                          text: widget.emailController,
                                          style: AppTextStyles
                                              .textStyleBoldBodyXSmall,
                                        ),
                                        TextSpan(
                                          text:
                                              " This will help you login faster next time.",
                                          style: AppTextStyles
                                              .textStyleNormalBodyXSmall,
                                        )
                                      ]))),
                            ),
                            Gap.h(30),
                            CustomTextField(
                              obsecuretext: x % 2 == 0 ? false : true,
                              // height: 30,
                              width: size.width * .90,
                              controller: passwordController,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labeltext: "Password",
                              suffixIcon: x % 2 != 0
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {});
                                        x = VariableProvider.IncrementVariable(
                                            x);
                                      },
                                      icon: const Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {});
                                        x = VariableProvider.IncrementVariable(
                                            x);
                                      },
                                      icon: const Icon(
                                        Icons.visibility,
                                        size: 20,
                                      )),
                              suffixIconColor: AppColors.grey,
                            ),
                            Gap.h(20),
                            CustomTextField(
                              obsecuretext: y % 2 == 0 ? false : true,
                              width: size.width * .90,
                              controller: confirmpasswordController,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: AppColors.grey)),
                              // hintText: "Confirm Password",
                              labeltext: "Confirm Password",
                              suffixIcon: y % 2 != 0
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {});
                                        y = VariableProvider.IncrementVariable(
                                            y);
                                      },
                                      icon: const Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {});
                                        y = VariableProvider.IncrementVariable(
                                            y);
                                      },
                                      icon: const Icon(
                                        Icons.visibility,
                                        size: 20,
                                      )),
                              suffixIconColor: AppColors.grey,
                            ),
                            // ),
                            const Spacer(),
                            CustomButton(
                                onTap: () async {
                                  if (passwordController.text.isEmpty) {
                                    showSnack(
                                        context: context,
                                        text: "Please Enter Password");
                                  } else if (confirmpasswordController
                                      .text.isEmpty) {
                                    showSnack(
                                        context: context,
                                        text: "Please Enter Confirm Password");
                                  } else if (passwordController.text !=
                                      confirmpasswordController.text) {
                                    showSnack(
                                        context: context,
                                        text: "Please Enter Correct Password");
                                  } else if (passwordController.text.length <
                                      6) {
                                    showSnack(
                                        context: context,
                                        text:
                                            "Password must at least 6 character long");
                                  } else {
                                    Future.delayed(
                                            const Duration(microseconds: 200))
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
                                            await Geolocator
                                                .isLocationServiceEnabled();
                                        if (isLocationServiceEnabled) {
                                          location = await Geolocator
                                              .getCurrentPosition();
                                          // Handle the received location data
                                          var pro =
                                              context.read<SignUpProvider>();
                                          await pro.signUpFirebase(
                                            context,
                                            widget.fullName,
                                            widget.emailController,
                                            passwordController.text,
                                            lat: location!.latitude.toInt(),
                                            long: location!.longitude.toInt(),
                                          );

                                          // handleLocation(await Geolocator.getCurrentPosition());

                                          return;
                                        }
                                        _handleEnableLocationScenarios();
                                      }
                                    });
                                  }
                                },
                                text: "Next"),

                            Gap.h(20),
                          ],
                        ),
                      ),
                    ),
                  ],
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
    var pro = context.read<SignUpProvider>();
    await pro.signUpFirebase(
      context,
      widget.fullName,
      widget.emailController,
      passwordController.text,
      lat: location!.latitude.toInt(),
      long: location!.longitude.toInt(),
    );
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
        var pro = context.read<SignUpProvider>();
        await pro.signUpFirebase(
          context,
          widget.fullName,
          widget.emailController,
          passwordController.text,
          lat: location!.latitude.toInt(),
          long: location!.longitude.toInt(),
        );
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
