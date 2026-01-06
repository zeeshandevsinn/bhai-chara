import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/app_config.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/view/authentication/otp_code_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../common/custom_button.dart';
import '../../controller/provider/visibility_provider.dart';


import '../../utils/custom_textfield.dart';
import '../../utils/push.dart';

// ignore: must_be_immutable
class CreatePasswardScreen extends StatelessWidget {
  CreatePasswardScreen({super.key,});
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final VisibilityProvider1 passwordVisibilityProvider = VisibilityProvider1();
  final VisibilityProvider2 confirmPasswordVisibilityProvider =
      VisibilityProvider2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
       appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
         title: Text(
                "Create Password",
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Gap.h(10),
          ChangeNotifierProvider(
            create: (_) => VisibilityProvider1(),
            child: CustomeTextField(
              hinttext: 'Password',
              controller: passwordController,
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => VisibilityProvider2(),
            child: CustomeTextField(
              hinttext: 'Confirm Password',
              controller: confirmPasswordController,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 24, right: 24, top: 20),
              child: CustomButton(
                onTap: (){push(context, OTPScreen());},
                text: "Next",
              )),
        ],
      ),
    );
  }
}
