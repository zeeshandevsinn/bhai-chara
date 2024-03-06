import 'package:bhai_chara/common/custom_container_children.dart';
import 'package:bhai_chara/common/custom_container_tile.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/app_config.dart';
import 'package:bhai_chara/utils/container_with_img.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/view/home-screens/product_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  TextEditingController searchController = TextEditingController();

  List<String> sellCategory = [
    "Animal",
    "Electronic",
    "Mobile",
    "Furniture",
    "Bike",
    "Bell",
  ];
  List<String> type = [
    "All",
    "Free",
    "Paid",
  ];
  List<String> selling = [
    'assets/images/fluent_animal-cat-28-filled.png',
    'assets/images/basil_camera-solid.png',
    'assets/images/fontisto_mobile.png',
    'assets/images/map_furniture-store.png',
    'assets/images/ri_motorbike-fill.png',
    'assets/images/solar_bell-bold.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<SelectionProvider>(
          builder: (context, provider, child) => SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.white,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: CustomTextField(
                            prfixicon: const Icon(Icons.search),
                            prefixcolor: AppColors.Grey,
                            controller: searchController,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "What are you looking for?",
                            obsecuretext: false),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _settingModalBottomSheet(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.tune),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Products")
                        .where("uid",
                            isNotEqualTo:
                                FirebaseAuth.instance.currentUser?.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        QuerySnapshot data = snapshot.data;
                        List<DocumentSnapshot> filteredData = [];

                        for (int index = 0; index < data.docs.length; index++) {
                          DocumentSnapshot dataDoc = data.docs[index];
                          bool isFree = dataDoc.get('isFree');
                          bool isCategory = dataDoc.get('category') ==
                              provider.selectedCategory;
                          if (provider.selectedCategory.isEmpty) {
                            isCategory = true;
                          }

                          if ((provider.selectedType == "All" ||
                                  (provider.selectedType == "Free" && isFree) ||
                                  (provider.selectedType == "Paid" &&
                                      !isFree)) &&
                              (isCategory)) {
                            print("lllll$isCategory");
                            if (dataDoc
                                .get('title')
                                .toString()
                                .toLowerCase()
                                .startsWith(
                                    searchController.text.toLowerCase())) {
                              filteredData.add(dataDoc);
                            } else if (searchController.text.isEmpty) {
                              filteredData.add(dataDoc);
                            }
                          }
                        }
                        if (filteredData.isEmpty) {
                          return const Center(child: Text("No data Found!"));
                        } else {
                          return GridView.builder(
                            itemCount: filteredData.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot dataDoc = filteredData[index];

                              return CustomContainerBox(
                                isfree: dataDoc.get('isFree'),
                                text: dataDoc.get('title'),
                                secondText: dataDoc.get('description'),
                                imgLink:
                                    NetworkImage(dataDoc.get('urlImage')[0]),
                                ontap: () {
                                  push(
                                    context,
                                    ProductScreen(
                                      id: dataDoc.id,
                                    ),
                                  );
                                },
                              );
                            },

                            // ignore: prefer_const_constructors
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: .85),
                          );
                        }
                      } else {
                        return const Center(child: CustomLoader());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  void _settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Consumer<SelectionProvider>(
          builder: (context, provider, child) {
            return IntrinsicHeight(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    Text(
                      "Select Type",
                      style: AppTextStyles.textStyleNormalBody_BlackColor
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Gap.h(7),
                    Row(
                      children: type
                          .map((e) => GestureDetector(
                                onTap: () {
                                  provider.updateSelectedType(e);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: CustomContainerText(
                                    style: provider.selectedType == e
                                        ? AppTextStyles.textStyleNormalBodySmall
                                            .copyWith(color: AppColors.white)
                                        : AppTextStyles
                                            .textStyleNormalBodyXSmall
                                            .copyWith(color: AppColors.black),
                                    container_color: provider.selectedType == e
                                        ? AppColors.blue
                                        : null,
                                    text: e,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    Gap.h(10),
                    Text(
                      "Select Categories",
                      style: AppTextStyles.textStyleNormalBody_BlackColor
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Gap.h(7),
                    Wrap(
                      children: List.generate(
                          sellCategory.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  provider.updateSelectedCategory(
                                      sellCategory[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: CustomCateContainerText(
                                    style: provider.selectedCategory ==
                                            sellCategory[index]
                                        ? AppTextStyles.textStyleNormalBodySmall
                                            .copyWith(color: AppColors.white)
                                        : AppTextStyles
                                            .textStyleNormalBodyXSmall
                                            .copyWith(color: AppColors.black),
                                    container_color:
                                        provider.selectedCategory ==
                                                sellCategory[index]
                                            ? AppColors.blue
                                            : null,
                                    text: sellCategory[index],
                                    image: selling[index],
                                    isSelected: provider.selectedCategory ==
                                        sellCategory[index],
                                  ),
                                ),
                              )).toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SelectionProvider with ChangeNotifier {
  String selectedType = "All";
  String selectedCategory = '';

  void updateSelectedType(String type) {
    selectedType = type;
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  clean() {
    selectedCategory = '';
    selectedType = "All";
    notifyListeners();
  }
}

// ignore: must_be_immutable
class CustomCateContainerText extends StatelessWidget {
  CustomCateContainerText(
      {super.key,
      this.text,
      this.style,
      this.container_color,
      this.image,
      required this.isSelected});
  var text, style, container_color;
  final String? image;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      decoration: BoxDecoration(
        color: container_color,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            color: isSelected ? Colors.white : Colors.black,
            image!,
            height: 20,
          ),
          Center(
            child: Text(
              text,
              style: style == null
                  ? AppTextStyles.textStyleNormalBody_BlackColor
                  : style,
            ),
          ),
        ],
      ),
    );
  }
}
