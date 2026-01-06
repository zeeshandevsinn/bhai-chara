// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:bhai_chara/common/custom_button.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/view/home-screens/sell_sub_categorie_screen.dart';
import 'package:bhai_chara/view/post%20and%20detail/post_and_detail_1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../common/custom_container_tile.dart';
import '../../common/custom_container_tile.dart';
import '../../controller/provider/sellscreen_provider/sellscreenprovider.dart';
import '../../utils/circle_avatar_row.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final List<Color> myColors = [
    const Color(0xfaF7931E),
    const Color.fromARGB(255, 247, 147, 30),
    const Color.fromARGB(255, 254, 192, 15),
    const Color.fromARGB(255, 57, 181, 74),
    const Color.fromARGB(255, 238, 42, 123),
    const Color.fromARGB(255, 39, 170, 225),
    const Color.fromARGB(255, 128, 128, 128),
    const Color.fromARGB(255, 179, 179, 179),
    const Color.fromARGB(255, 101, 101, 101),
    const Color.fromARGB(255, 202, 93, 93),
    const Color.fromARGB(255, 226, 70, 200),
    const Color.fromARGB(248, 6, 110, 29),
    Colors.cyan,
    const Color(0xff001B26),
    const Color(0xfa001B26),
    const Color.fromARGB(255, 0, 27, 38),
    Colors.black,
    const Color(0xff000000),
    const Color.fromARGB(249, 70, 2, 17),
  ];

  final List<String> sellCategory = [
    "Animal",
    "Electronic",
    "Mobile",
    "Furniture",
    "Bike",
    "Car",
  ];

  final List<String> selling = [
    'assets/images/fluent_animal-cat-28-filled.png',
    'assets/images/basil_camera-solid.png',
    'assets/images/fontisto_mobile.png',
    'assets/images/map_furniture-store.png',
    'assets/images/ri_motorbike-fill.png',
    'assets/images/colorcar.png',
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SellScreenProvider>();
    final size = MediaQuery.of(context).size;

    Random random = Random();
    List<Color> randomColorList = List.generate(
      sellCategory.length,
      (_) => myColors[random.nextInt(myColors.length)],
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          "What are you offering?",
          style: AppTextStyles.textStyleBoldBodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
              child: Text(
                "Categories",
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
            ),

            /// Categories
            for (int i = 0; i < selling.length; i++)
              CustomCircleAvatarRow(
                selected: false,
                link: selling[i],
                col: randomColorList[i],
                txt: sellCategory[i],
                ontap: () {
                  push(
                    context,
                    SubCategorieScreen(
                      link: selling[i],
                      color: randomColorList[i],
                      text: sellCategory[i],
                    ),
                  );
                },
              ),

            /// Other option
            CustomCircleAvatarRow(
              selected: provider.selected,
              link: 'assets/images/logo.png',
              txt: 'Other',
              col: AppColors.white,
              ontap: provider.toggleTextFieldVisibility,
            ),

            const SizedBox(height: 10),

            /// Text field
            if (provider.selected)
              Center(
                child: CustomTextField(
                  width: size.width * .80,
                  hintText: "Category",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  controller: provider.otherController,
                  obsecuretext: false,
                ),
              ),

            const SizedBox(height: 5),

            /// Next button
            Visibility(
              visible: !provider.isTextFieldEmpty,
              child: CustomButton(
                width: size.width * .30,
                text: "Next",
                onTap: () {
                  final text = provider.otherController.text;

                  provider.toggleTextFieldVisibility();
                  provider.clearText();

                  push(
                    context,
                    PostDetailScreen1(
                      subtext: "",
                      link: 'assets/images/logo.png',
                      color: Colors.white,
                      titletext: text,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
