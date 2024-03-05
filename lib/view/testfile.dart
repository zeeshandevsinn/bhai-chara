import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:flutter/material.dart';

import '../utils/custom_loader.dart';

class TestFile extends StatefulWidget {
  const TestFile({super.key});

  @override
  State<TestFile> createState() => _TestFileState();
}

class _TestFileState extends State<TestFile> {
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CustomLoader(),
          Container(
              margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => const AlertDialog(
                    title: Text("Wait for Verification OTP"),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Never tab Back"),
                      ],
                    ),
                    actions: <Widget>[CustomLoader()],
                  ),
                );
                showSnack(context: context, text: "Hi Dialogue Box");
              },
              // onPressed: showLoaderDialog(context),
              child: const Icon(
                Icons.favorite,
                size: 30,
              ))),
    );
  }
}
