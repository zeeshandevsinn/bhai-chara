import 'package:bhai_chara/controller/provider/root_provider.dart';
import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
import 'package:bhai_chara/controller/services/shared_prefrences.dart';
import 'package:bhai_chara/model/user_model.dart';

import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/recredential_alert.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/view/authentication/login_screen.dart';
import 'package:bhai_chara/view/item/item_screen.dart';
import 'package:bhai_chara/view/settings-screens/about_us.dart';

import 'package:bhai_chara/view/settings-screens/edit_profile.dart';

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:bhai_chara/view/settings-screens/privacy_policy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../home-screens/premiumscreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper.instance();
  UserModel? _userData;
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

/////////// UPDATE PROFILE //////////////
  void fetchUserData() async {
    UserModel? userData = await _sharedPreferenceHelper.user();
    setState(() {
      _userData = userData;
    });
  }

  bool isloading = false;
  Future<void> deleteAccount(String email, String password) async {
    try {
      setState(() {
        isloading = true;
      });
      await FirebaseManager.deleteAccount(email, password);
      await _sharedPreferenceHelper.clear();
      context.read<RootProvider>().setSelectedScreen(0);
      showSnack(context: context, text: 'User account deleted successfully');
      pushUntil(context, LoginScreen());
    } catch (e) {
      showSnack(context: context, text: e.toString());
      setState(() {
        isloading = false;
      });
      // Handle error here
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        body: Padding(
          padding: const EdgeInsets.all(10),
          //********************************//
          //**********Edit Profile**********//
          //********************************//
          child: isloading == true
              ? const Center(
                  child: CustomLoader(),
                )
              : ListView(
                  children: [
                    _userData != null
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => ProfileEdit(
                                          userdata: _userData!))).then((value) {
                                fetchUserData();
                              });
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      _userData!.image == ""
                                          ? Container(
                                              height: 80,
                                              width: 80,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/profile_photo.png"),
                                                  fit: BoxFit
                                                      .cover, // Adjust this according to your requirement
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: NetworkImage(_userData!
                                                      .image
                                                      .toString()),
                                                  fit: BoxFit
                                                      .cover, // Adjust this according to your requirement
                                                ),
                                              ),
                                            ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _userData!.name.toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Text(_userData!.email.toString())
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),

                    Column(
                      children: [
                        SettingsItem(
                          onTap: () {
                            push(context, const ItemScreen());
                          },
                          icons: Icons.ads_click,
                          iconStyle: IconStyle(
                            iconsColor: Colors.white,
                            withBackground: true,
                            backgroundColor: Colors.red,
                          ),
                          title: 'My Ads',
                          // subtitle: "",
                        ),
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 12),
                        //   child: Divider(),
                        // ),
                        // SettingsItem(
                        //   onTap: () {
                        //     // Navigator.push(
                        //     //     context,
                        //     //     MaterialPageRoute(
                        //     //         builder: (context) => const ContactSupport()));
                        //   },
                        //   icons: Icons.support_agent,
                        //   iconStyle: IconStyle(
                        //     iconsColor: Colors.white,
                        //     withBackground: true,
                        //     backgroundColor: Colors.pink.shade200,
                        //   ),
                        //   title: 'Contact Support',
                        //   // subtitle: "",
                        // ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Divider(),
                        ),
                        SettingsItem(
                          onTap: () {
                            push(context, PrivacyPolicyScreen());
                          },
                          icons: Icons.privacy_tip,
                          iconStyle: IconStyle(
                            iconsColor: Colors.white,
                            withBackground: true,
                            backgroundColor: Colors.grey.shade500,
                          ),
                          title: 'Privacy Policy',
                          // subtitle: "",
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Divider(),
                        ),
                        SettingsItem(
                          onTap: () {
                            push(context, AboutUsScreen());
                          },
                          icons: Icons.info_rounded,
                          iconStyle: IconStyle(
                            backgroundColor: Colors.purple,
                          ),
                          title: 'About',
                        ),

                        SettingsItem(
                          onTap: () {
                            push(context, const PremiumScreen());
                          },
                          icons: Icons.workspace_premium_rounded,
                          iconStyle: IconStyle(
                            backgroundColor: Colors.purple,
                          ),
                          title: 'Unlock premium',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Account',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SettingsItem(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/Bhai Chara svg 1.png'),
                                    height: 45,
                                    width: 45,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "BHI CHARA",
                                    style: TextStyle(color: AppColors.blue),
                                  ),
                                ],
                              ),
                              content: const Text(
                                "Are you sure you want to log out?",
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 16),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    isDefaultAction: true,
                                    isDestructiveAction: true,
                                    child: const Text(
                                      "Log Out",
                                      style: TextStyle(color: AppColors.error),
                                    ),
                                    onPressed: () async {
                                      _sharedPreferenceHelper.clear();
                                      await FirebaseAuth.instance
                                          .signOut()
                                          .then((value) {
                                        context
                                            .read<RootProvider>()
                                            .setSelectedScreen(0);
                                        pushUntil(context, LoginScreen());
                                      });
                                    }),
                                CupertinoDialogAction(
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: AppColors.blue),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icons: Icons.exit_to_app_rounded,
                      title: "Sign Out",
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Divider(),
                    ),
                    //**********************************//
                    //**********Delete Account**********//
                    //**********************************//
                    SettingsItem(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return RecredentialAlert(
                                buttoncolor: Colors.black,
                                buttoncolor2: Colors.black,
                                textbutton1: 'Confirm',
                                emailController:
                                    emailController, // Pass email controller
                                passwordController: passwordController,

                                onPressed: () {
                                  String email = emailController.text;
                                  String password = passwordController.text;

                                  deleteAccount(email, password);
                                  Navigator.pop(context);
                                },
                              );
                            });
                      },
                      icons: CupertinoIcons.delete_solid,
                      title: "Delete account",
                      titleStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ));
  }
}


                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return CupertinoAlertDialog(
                  //       title: const Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Image(
                  //             image: AssetImage(
                  //                 'assets/images/Bhai Chara svg 1.png'),
                  //             height: 45,
                  //             width: 45,
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             "BHI CHARA",
                  //             style: TextStyle(color: AppColors.blue),
                  //           ),
                  //         ],
                  //       ),
                  //       content: const Text(
                  //         "Are you sure you want to Delete Account?",
                  //         style:
                  //             TextStyle(color: AppColors.black, fontSize: 16),
                  //       ),
                  //       actions: [
                  //         CupertinoDialogAction(
                  //             isDefaultAction: true,
                  //             isDestructiveAction: true,
                  //             child: const Text(
                  //               "Delete",
                  //               style: TextStyle(color: AppColors.error),
                  //             ),
                  //             onPressed: () async {
                  //             
                  //             }),
                  //         CupertinoDialogAction(
                  //           child: const Text(
                  //             "Cancel",
                  //             style: TextStyle(color: AppColors.blue),
                  //           ),
                  //           onPressed: () {
                  //             Navigator.pop(context);
                  //           },
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );
             
             