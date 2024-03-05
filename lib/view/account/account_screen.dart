import 'package:bhai_chara/common/custom_list_tile.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/view/help_and_sports_screen.dart';
import 'package:bhai_chara/view/item/item_screen.dart';
import 'package:bhai_chara/view/settings-screens/setting_screen.dart';

import 'package:flutter/material.dart';
import '../../common/custom_listtile.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.white,
         title: Text(
                "Account",
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
      
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomListAccountTile(
              asset_image: const AssetImage("assets/images/profile_photo.png"),
              subtitle_text: "View and edit profile",
              subtitle_style: AppTextStyles.textStyleSubtitleUnderlineBody,
              title_style: AppTextStyles.textStyleBoldBodyMedium,
              title_text: "Arham Sarwar",
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomListTileSetting(
                  tap: () {
                    push(context, const ItemScreen());
                  },
                  heading: "My Add's", 
                  data: 'All added items',
                  iconOne: Icons.ads_click,
                ),
                CustomListTileSetting(
                  tap: () {
                    push(context, const SettingScreen());
                  },
                  heading: "Settings",
                  data: 'Privacy and manage account',
                  iconOne: Icons.settings,
                ),
                CustomListTileSetting(
                  tap: () {
                    push(context, const HelpAndSportsScreen());
                  },
                  heading: "Help and Supports",
                  data: 'Help center and legal terms',
                  iconOne: Icons.help,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
