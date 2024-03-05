// ignore_for_file: must_be_immutable

import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/app_config.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/view/post%20and%20detail/post_and_detail_1.dart';
import 'package:flutter/material.dart';


class SubCategorieScreen extends StatefulWidget {
  SubCategorieScreen({super.key, this.link, this.text, this.color});
  var link, text, color;
  @override
  State<SubCategorieScreen> createState() => _SubCategorieScreenState();
}

class _SubCategorieScreenState extends State<SubCategorieScreen> {
  final List<String> animalCategories = [
    'Mammals',
    'Birds',
    'Reptiles',
    'Amphibians',
    'Fish',
    'Invertebrates',
    'Arthropods',
    'Mollusks',
    'Echinoderms',
    'Cnidarians',
    'Annelids',
    'Porifera',
    'Platyhelminthes',
    'Nematodes',
    'Coelenterates',
    'Arachnids',
    'Insects',
    'Crustaceans',
    'Mammals',
    'Birds',
    'Marsupials',
    'Primates',
    'Carnivores',
    'Herbivores',
    'Rodents',
    'Hoofed Animals',
    'Marine Animals',
    'Domesticated Animals',
    'Endangered Species',
    'Extinct Animals'
  ];
  List<String> electronics = [
    'Smartphone',
    'Laptop',
    'Tablet',
    'Smartwatch',
    'Television',
    'Digital Camera',
    'Bluetooth Speaker',
    'Headphones',
    'Gaming Console',
    'Router',
  ];
  List<String> mobilePhones = [
    'iPhone',
    'Samsung Galaxy',
    'Google Pixel',
    'OnePlus',
    'Sony Xperia',
    'LG G Series',
    'Motorola Moto',
    'Huawei',
    'Xiaomi',
    'Oppo',
  ];
  List<String> furniture = [
    'Sofa',
    'Dining Table',
    'Bed',
    'Wardrobe',
    'Coffee Table',
    'Bookshelf',
    'Office Chair',
    'Dresser',
    'Recliner',
    'Nightstand',
  ];
  List<String> motorcycles = [
    'Harley-Davidson',
    'Honda',
    'Yamaha',
    'Kawasaki',
    'Suzuki',
    'Ducati',
    'BMW Motorrad',
    'Triumph',
    'KTM',
    'Indian Motorcycle',
  ];
  List<String> BellsSubCategory = [
    'Crane Bell Co.',
    'Spurcycle',
    'Knog',
    'Timber!',
    'Mirrycle',
    'Lezyne',
    'Incredibell',
    'Electra',
    'Cateye',
    'RockBros',
  ];
  var lengthSide = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: Text(
                "What are you offering?",
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Sub-Categories",
                    style: AppTextStyles.textStyleBoldBodyMedium),
                Gap.h(10),
                SingleChildScrollView(
                  child: Builder(builder: (context) {
                    if (widget.text == "Animal") {
                      lengthSide = animalCategories.length;
                    } else if (widget.text == "Electronic") {
                      lengthSide = electronics.length;
                    } else if (widget.text == "Mobile") {
                      lengthSide = mobilePhones.length;
                    } else if (widget.text == "Furniture") {
                      lengthSide = furniture.length;
                    } else if (widget.text == "Bike") {
                      lengthSide = motorcycles.length;
                    } else if (widget.text == "Bell") {
                      lengthSide = BellsSubCategory.length;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        for (var i = 0; i < lengthSide; i++)
                          InkWell(
                            onTap: () {
                              push(
                                  context,
                                  PostDetailScreen1(
                                    subtext: widget.text == "Animal"
                                        ? animalCategories[i]
                                        : widget.text == "Electronic"
                                            ? electronics[i]
                                            : widget.text == "Mobile"
                                                ? mobilePhones[i]
                                                : widget.text == "Furniture"
                                                    ? furniture[i]
                                                    : widget.text == "Bike"
                                                        ? motorcycles[i]
                                                        : widget.text == "Bell"
                                                            ? BellsSubCategory[
                                                                i]
                                                            : "",
                                    link: widget.link,
                                    color: widget.color,
                                    titletext: widget.text,
                                  ));
                            },
                            child: Text(
                                widget.text == "Animal"
                                    ? animalCategories[i]
                                    : widget.text == "Electronic"
                                        ? electronics[i]
                                        : widget.text == "Mobile"
                                            ? mobilePhones[i]
                                            : widget.text == "Furniture"
                                                ? furniture[i]
                                                : widget.text == "Bike"
                                                    ? motorcycles[i]
                                                    : widget.text == "Bell"
                                                        ? BellsSubCategory[i]
                                                        : "",
                                style: AppTextStyles.textStyleNormalBodyMedium),
                          ),
                      ],
                    );
                  }),
                )
              ]),
        ),
      ),
    );
  }
}
