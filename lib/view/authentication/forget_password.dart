// ignore_for_file: deprecated_member_use

import 'package:bhai_chara/common/custom_button.dart';
import 'package:bhai_chara/common/custom_container_tile.dart';
import 'package:bhai_chara/controller/provider/authentication_provider/login_provider.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/utils/utils.dart';
import 'package:bhai_chara/view/authentication/signup_screen.dart';
import 'package:bhai_chara/view/onboard_screens/onboard_screen_three.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/authentication_provider/variable.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var x = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        var pro = context.watch<LoginProvider>();
        pro.isLoading = false;
        return pop(context);
        // return push(context, const OnboardScreenThree());
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
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
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
                        CustomButton(
                          onTap: () async {
                            if (emailController.text.isEmpty) {
                              showSnack(
                                  context: context, text: "Please Enter Email");
                            } else{
                              pro.forgotPassword(email: emailController.text.trim(),context: context);
                            }
                          },
                          text: "Continue",
                          width: size.width * .90,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                       CustomButton(onTap: (){
                        pop(context);
                       },text: 'Login',)
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
