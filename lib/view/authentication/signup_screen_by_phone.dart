// ignore_for_file: use_build_context_synchronously, avoid_unnecessary_containers

import 'dart:developer';

import 'package:bhai_chara/common/custonPhoneTextField.dart';
import 'package:bhai_chara/controller/provider/authentication_provider/firebase_signup_provider.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/app_config.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/view/authentication/otp_code_screen.dart';
import 'package:bhai_chara/view/home-screens/root_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/custom_button.dart';
import '../../controller/provider/phone_number.dart';
import '../../utils/custom_loader.dart';

class SignUpScreenByPhone extends StatefulWidget {
  const SignUpScreenByPhone({super.key});

  @override
  State<SignUpScreenByPhone> createState() => _SignUpScreenByPhoneState();
}

bool selected = true;
String completePhoneNumber = '';

class _SignUpScreenByPhoneState extends State<SignUpScreenByPhone> {
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size;
    // Navigator.pop(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Builder(builder: (context) {
        // ignore: unused_local_variable
        var phone = context.watch<SignUpProvider>();
        return Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap.h(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                          // color: AppColors.primary,
                          image: DecorationImage(
                              scale: 1,
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.contain)),
                    ),
                  ],
                ),
                Gap.h(50),
                Text(
                  "Enter your phone",
                  style: AppTextStyles.textStyleBoldSubTitleLarge,
                ),
                Gap.h(10),
                Container(
                    child: Text(
                  "We will send a confirmation code to your phone",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.textStyleNormalBodyXSmall,
                )),
                Gap.h(20),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    hintText: "+923001234567", // 🔑 E.164 format
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                // CustomCountryPhoneField(
                //   controller: numberController,
                //   completePhoneNumber: completePhoneNumber,
                // ),
                SizedBox(
                  height: (size.height < 300)
                      ? size.height * .10
                      : size.height * .28,
                ),

                Consumer<SignUpProvider>(builder: (context, p, child) {
                  return p.isLoading
                      ? const CustomLoader()
                      : CustomButton(
                          onTap: () async {
                            if (numberController.text.isEmpty) {
                              showSnack(
                                  context: context,
                                  text: "Please Enter Phone Field");
                            } else {
                              FocusScope.of(context).unfocus();
                              var data = context.read<SignUpProvider>();

                              await data.PhoneVerifyFireBase(
                                  context, numberController.text.trim());

                              // numberController =
                              //     await CustomCountryPhoneField().controller;
                            }
                          },
                          text: "Next",
                        );
                }),
                Gap.h(10),
                CustomButton(
                  colorBox: AppColors.grey,
                  onTap: () async {
                    push(context, RootScreen());
                  },
                  text: "Skip",
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
