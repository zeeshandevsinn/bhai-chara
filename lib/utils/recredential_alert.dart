import 'package:bhai_chara/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecredentialAlert extends StatefulWidget {
  String? maintext;
  String? text1;
  String? textbutton1;
  Color? buttoncolor;
  Color? buttoncolor2;
  final VoidCallback? onPressed;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  RecredentialAlert(
      {super.key,
      this.buttoncolor,
      this.buttoncolor2,
      this.maintext,
      this.onPressed,
      this.text1,
      this.emailController,
      this.passwordController,
      this.textbutton1});

  @override
  State<RecredentialAlert> createState() => _RecredentialAlertState();
}

class _RecredentialAlertState extends State<RecredentialAlert> {
  bool isEmailValid = false;
  bool isPasswordValid = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.emailController!.clear();
    widget.passwordController!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage('assets/images/Bhai Chara svg 1.png'),
            height: 45,
            width: 45,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "BHI CHARA",
            style: TextStyle(color: AppColors.black),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: widget.emailController,
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: AppColors.black),
                labelText: 'Email',
                errorText: isEmailValid ? null : 'Please enter a valid email',
                 errorStyle: TextStyle(color: AppColors.grey),
              ),
              onChanged: (value) {
                setState(() {
                  isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value);
                });
              },
            ),
            TextField(
              
              controller: widget.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: AppColors.black),
                labelText: 'Password',
                errorText:
                    isPasswordValid ? null : 'Please enter a valid password',
                     errorStyle: TextStyle(color: AppColors.grey),
              ),
              onChanged: (value) {
                setState(() {
                  isPasswordValid = value.length >= 6;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              if (isEmailValid && isPasswordValid) {
                // Perform your action here
                widget.onPressed!.call();
              }
            },
            child: Text(
              widget.textbutton1!,
              style: const TextStyle(color: AppColors.black),
            )),
        TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.red),
            ))
      ],
    );
  }
}
