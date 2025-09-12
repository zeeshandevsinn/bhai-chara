import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/app_config.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/itemContainer.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/firebase/addproduct.dart';
import '../../utils/push.dart';
import '../account/account_screen.dart';
import '../help_and_sports_screen.dart';
import '../home-screens/product_details_screen.dart';
import '../settings-screens/manage_account_screen.dart';
import '../settings-screens/setting_screen.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var currentIndex;
    // ignore: unused_local_variable
    final pages = [
      const AccountScreen(),
      const ItemScreen(),
      const HelpAndSportsScreen(),
      const ManageAccountScreen(),
      const SettingScreen(),
    ];
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
       appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: Text(
                "Items",
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
        centerTitle: true,
        // actions: [
        //   IconButton(onPressed: (){
        //     FirebaseAuth.instance.signOut();
        //   }, icon: Icon(Icons.star)),
        // ],
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("Products").snapshots(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Gap.h(10),
                        // CustomContainerTile(
                        //   ontap: () {},
                        //   height: 40.0,
                        //   width: 100.0,
                        //   chil_widget: const Icon(
                        //     Icons.tune,
                        //     size: 20,
                        //     color: AppColors.grey,
                        //   ),
                        //   text: "Filter",
                        //   style_text:
                        //       AppTextStyles.textStyleNormalXLBodySmall,
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(PRODUCT_COLLECTION).where("uid",isEqualTo: FirebaseAuth.instance.currentUser?.uid )
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              var pro = context.watch<ProductProvider>();
                              if (snapshot.hasData) {
                                QuerySnapshot data = snapshot.data;
    
                                return pro.isLoading
                                    ? const Center(child: CustomLoader())
                                    : data.docs.isEmpty ? Center(child: Text("No Items Found"),) : ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: data.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot dataDoc =
                                              data.docs[index];

                                           String docid = dataDoc.id;
                                          var isFree = dataDoc.get('isFree')
                                              ? "Free"
                                              : dataDoc.get('price');
                                          return ItemContainer(
                                            time: dataDoc.get('Time'),
                                            title:dataDoc.get('title'),
                                            subcategory:
                                                dataDoc.get('subcategory'),
                                            category: dataDoc.get('category'),
                                            imageLink:
                                                dataDoc.get('urlImage')[0],
                                            titleText: isFree,
                                            docid: docid,
                                            ontap: () {
                                              push(
                                                  context,
                                                  ProductScreen(
                                                    where: 'yes',
                                                    id: dataDoc.id,
                                                  ));
                                            },
                                          );
                                        },
                                      );
                              } else
                                return const Center(
                                  child: CustomLoader(),
                                );
                            }),
                    
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
