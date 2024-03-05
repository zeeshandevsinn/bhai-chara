import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/listtile_custom.dart';

class HelpAndSportsScreen extends StatefulWidget {
  const HelpAndSportsScreen({super.key});

  @override
  State<HelpAndSportsScreen> createState() => _HelpAndSportsScreenState();
}

class _HelpAndSportsScreenState extends State<HelpAndSportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
       appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: Text(
                "Help and Supports",
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomListTile(
                  tap: () {
                    BottomSheetFunction(context);
                  },
                  title: "Feedback",
                  subtitle: "Take a moment to let us konw how we’re doing",
                ),
                const Divider(
                  thickness: 2,
                  color: AppColors.dividerColor,
                ),
                CustomListTile(
                  tap: () {
                    //push(context, ManageAccountScreen());
                  },
                  title: "Invite friends to Bhai Chara",
                  subtitle: "Invite your friends to buy and sell",
                ),
                const Divider(
                  thickness: 2,
                  color: AppColors.dividerColor,
                ),
                CustomListTile(
                  tap: () {
                    //push(context, ManageAccountScreen());
                  },
                  title: "Version",
                  subtitle: "23.1",
                ),
                const Divider(
                  thickness: 2,
                  color: AppColors.dividerColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
