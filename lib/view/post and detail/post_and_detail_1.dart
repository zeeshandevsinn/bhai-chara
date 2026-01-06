// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';

import 'package:bhai_chara/common/custom_button.dart';
import 'package:bhai_chara/common/custom_container_children.dart';
import 'package:bhai_chara/common/custom_container_tile.dart';
import 'package:bhai_chara/common/custom_list_tile.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/view/post%20and%20detail/ImagesScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/Image_Picker/compress_provider.dart';
import '../../controller/provider/authentication_provider/auth_provider.dart';
import '../../controller/provider/firebase/addImages.dart';
import '../home-screens/root_screen.dart';

class PostDetailScreen1 extends StatefulWidget {
  PostDetailScreen1(
      {super.key, this.subtext, this.titletext, this.color, this.link});
  var subtext, titletext, color, link;
  @override
  State<PostDetailScreen1> createState() => _PostDetailScreen1State();
}

class _PostDetailScreen1State extends State<PostDetailScreen1> {
 
  TextEditingController priceController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController titlleController = TextEditingController();
  TextEditingController describeController = TextEditingController();
  List<File> selectedImages = [];
  List<File> compressedImage = [];
  List<String> urlImage = [];
  ImagePicker picker = ImagePicker();
  var selected = "";
  var loc;
  String pricing = "Paid";
  bool isFree = false;
  final coords = 0;

  String message = "";
  void rebuildPage() {
    var pro = context.watch<FireStoreProvider>();
    setState(() {
      pro.isLoading = false;
    });
  }

  final Map<String, Map<String, double>> citiesCoordinates = {
    "Abbottabad": {
      "lat": 34.168751,
      "lng": 73.221497
    }, // :contentReference[oaicite:0]{index=0}
    "Ahmadpur East": {
      "lat": 29.143644,
      "lng": 71.257240
    }, // :contentReference[oaicite:1]{index=1}
    "Attock": {
      "lat": 33.76671,
      "lng": 72.359766
    }, // :contentReference[oaicite:2]{index=2}
    "Bahawalnagar": {
      "lat": 29.99866,
      "lng": 73.25360
    }, // :contentReference[oaicite:3]{index=3}
    "Bahawalpur": {
      "lat": 29.418068,
      "lng": 71.670685
    }, // :contentReference[oaicite:4]{index=4}
    "Bannu": {
      "lat": 32.986111,
      "lng": 70.604164
    }, // :contentReference[oaicite:5]{index=5}
    "Bhakkar": {
      "lat": 31.633333,
      "lng": 71.066666
    }, // :contentReference[oaicite:6]{index=6}
    "Chakwal": {
      "lat": 32.56,
      "lng": 72.53
    }, // approximate: 32°56′N 72°53′E :contentReference[oaicite:7]{index=7}
    "Chaman": {
      "lat": 30.966667,
      "lng": 66.416667
    }, // approx 30°58′N 66°25′E :contentReference[oaicite:8]{index=8}
    "Charsadda": {
      "lat": 34.116667,
      "lng": 71.75
    }, // 34°07′N 71°45′E :contentReference[oaicite:9]{index=9}
    "Chiniot": {
      "lat": 31.75,
      "lng": 73.0
    }, // 31°45′N 73°00′E :contentReference[oaicite:10]{index=10}
    "Dadu": {
      "lat": 26.75,
      "lng": 67.75
    }, // 26°45′N 67°45′E :contentReference[oaicite:11]{index=11}
    "Dera Ghazi Khan": {
      "lat": 30.083,
      "lng": 70.717
    }, // approx 30°05′N 70°43′E :contentReference[oaicite:12]{index=12}
    "Dera Ismail Khan": {
      "lat": 31.833,
      "lng": 70.833
    }, // approx 31°50′N 70°50′E :contentReference[oaicite:13]{index=13}
    "Faisalabad": {
      "lat": 31.418715,
      "lng": 73.079109
    }, // :contentReference[oaicite:14]{index=14}
    "Ghotki": {
      "lat": 28.083333,
      "lng": 69.35
    }, // 28°05′N 69°21′E :contentReference[oaicite:15]{index=15}
    "Gujranwala": {
      "lat": 32.166351,
      "lng": 74.195900
    }, // :contentReference[oaicite:16]{index=16}
    "Gujrat": {
      "lat": 32.571144,
      "lng": 74.075005
    }, // :contentReference[oaicite:17]{index=17}
    "Gwadar": {
      "lat": 25.126389,
      "lng": 62.322498
    }, // :contentReference[oaicite:18]{index=18}
    "Hafizabad": {
      "lat": 32.071697,
      "lng": 73.685730
    }, // :contentReference[oaicite:19]{index=19}
    "Haripur": {
      "lat": 34.0,
      "lng": 72.933
    }, // approximate from region—data not explicit
    "Hyderabad": {
      "lat": 25.39689,
      "lng": 68.37718
    }, // :contentReference[oaicite:20]{index=20}
    "Islamabad": {
      "lat": 33.738045,
      "lng": 73.084488
    }, // :contentReference[oaicite:21]{index=21}
    "Jacobabad": {
      "lat": 28.281891,
      "lng": 68.438171
    }, // :contentReference[oaicite:22]{index=22}
    "Jhang": {
      "lat": 31.278046,
      "lng": 72.311760
    }, // :contentReference[oaicite:23]{index=23}
    "Jhelum": {
      "lat": 32.940548,
      "lng": 73.727631
    }, // :contentReference[oaicite:24]{index=24}
    "Kahuta": {
      "lat": 33.583,
      "lng": 73.4
    }, // approx from 33°35′N 73°24′E :contentReference[oaicite:25]{index=25}
    "Kamalia": {
      "lat": 30.747,
      "lng": 72.7
    }, // approx 30°44′N 72°42′E :contentReference[oaicite:26]{index=26}
    "Kamoke": {
      "lat": 31.975508,
      "lng": 74.223801
    }, // :contentReference[oaicite:27]{index=27}
    "Karachi": {
      "lat": 24.860966,
      "lng": 66.990501
    }, // :contentReference[oaicite:28]{index=28}
    "Kasur": {
      "lat": 31.118793,
      "lng": 74.463272
    }, // :contentReference[oaicite:29]{index=29}
    "Khanewal": {
      "lat": 30.286415,
      "lng": 71.932030
    }, // :contentReference[oaicite:30]{index=30}
    "Kharian": {
      "lat": 32.816,
      "lng": 73.883
    }, // approx from 32°49′N 73°52′E :contentReference[oaicite:31]{index=31}
    "Khushab": {
      "lat": 32.294445,
      "lng": 72.349724
    }, // :contentReference[oaicite:32]{index=32}
    "Khuzdar": {
      "lat": 27.866667,
      "lng": 66.5
    }, // approx 27°52′N 66°30′E :contentReference[oaicite:33]{index=33}
    "Kohat": {
      "lat": 33.667,
      "lng": 71.483
    }, // approx 33°40′N 71°29′E :contentReference[oaicite:34]{index=34}
    "Kot Adu": {
      "lat": 30.5,
      "lng": 71.0
    }, // 30°30′N 71°00′E :contentReference[oaicite:35]{index=35}
    "Kotli": {
      "lat": 33.5,
      "lng": 73.916667
    }, // 33°30′N 73°55′E :contentReference[oaicite:36]{index=36}
    "Lahore": {
      "lat": 31.582045,
      "lng": 74.329376
    }, // :contentReference[oaicite:37]{index=37}
    "Larkana": {
      "lat": 27.563993,
      "lng": 68.215134
    }, // :contentReference[oaicite:38]{index=38}
    "Layyah": {
      "lat": 30.96475,
      "lng": 70.939934
    }, // :contentReference[oaicite:39]{index=39}
    "Lodhran": {"lat": 29.5, "lng": 71.5}, // approximate (data unclear)
    "Malakand": {
      "lat": 34.666667,
      "lng": 71.916667
    }, // approx from 34°40′N 71°55′E :contentReference[oaicite:40]{index=40}
    "Mansehra": {
      "lat": 34.333333,
      "lng": 73.25
    }, // approx 34°20′N 73°15′E :contentReference[oaicite:41]{index=41}
    "Mardan": {
      "lat": 34.206123,
      "lng": 72.029800
    }, // :contentReference[oaicite:42]{index=42}
    "Mianwali": {
      "lat": 32.633333,
      "lng": 71.466667
    }, // approx 32°38′N 71°28′E :contentReference[oaicite:43]{index=43}
    "Mirpur": {
      "lat": 33.15,
      "lng": 73.75
    }, // (multiple cities—using New Mirpur City) :contentReference[oaicite:44]{index=44}
    "Mirpur Khas": {
      "lat": 25.529104,
      "lng": 69.013573
    }, // :contentReference[oaicite:45]{index=45}
    "Multan": {
      "lat": 30.181459,
      "lng": 71.492157
    }, // :contentReference[oaicite:46]{index=46}
    "Murree": {
      "lat": 33.9,
      "lng": 73.383333
    }, // 33°54′N 73°23′E :contentReference[oaicite:47]{index=47}
    "Muzaffarabad": {
      "lat": 34.359688,
      "lng": 73.471054
    }, // :contentReference[oaicite:48]{index=48}
    "Muzaffargarh": {
      "lat": 30.074377,
      "lng": 71.184654
    }, // :contentReference[oaicite:49]{index=49}
    "Nawabshah": {
      "lat": 26.244221,
      "lng": 68.410034
    }, // :contentReference[oaicite:50]{index=50}
    "Nowshera": {
      "lat": 34.015858,
      "lng": 71.975449
    }, // :contentReference[oaicite:51]{index=51}
    "Okara": {
      "lat": 30.8085,
      "lng": 73.459396
    }, // :contentReference[oaicite:52]{index=52}
    "Pakpattan": {"lat": 30.312, "lng": 73.389}, // estimated
    "Peshawar": {
      "lat": 34.025917,
      "lng": 71.560135
    }, // :contentReference[oaicite:53]{index=53}
    "Quetta": {
      "lat": 30.18327,
      "lng": 66.996452
    }, // :contentReference[oaicite:54]{index=54}
    "Rahim Yar Khan": {"lat": 28.420, "lng": 70.307}, // estimated
    "Rajanpur": {"lat": 28.6, "lng": 70.33}, // estimated
    "Rawalpindi": {
      "lat": 33.626057,
      "lng": 73.071442
    }, // :contentReference[oaicite:55]{index=55}
    "Sadiqabad": {
      "lat": 28.31,
      "lng": 70.1274
    }, // :contentReference[oaicite:56]{index=56}
    "Sahiwal": {
      "lat": 30.677717,
      "lng": 73.106812
    }, // :contentReference[oaicite:57]{index=57}
    "Sargodha": {
      "lat": 32.082466,
      "lng": 72.669128
    }, // :contentReference[oaicite:58]{index=58}
    "Sheikhupura": {
      "lat": 31.716661,
      "lng": 73.985023
    }, // :contentReference[oaicite:59]{index=59}
    "Shikarpur": {
      "lat": 27.955648,
      "lng": 68.637672
    }, // :contentReference[oaicite:60]{index=60}
    "Sialkot": {
      "lat": 32.497223,
      "lng": 74.536110
    }, // :contentReference[oaicite:61]{index=61}
    "Sukkur": {
      "lat": 27.713926,
      "lng": 68.836899
    }, // :contentReference[oaicite:62]{index=62}
    "Swabi": {"lat": 34.116667, "lng": 72.45}, // approximate
    "Swat": {
      "lat": 34.75,
      "lng": 72.35
    }, // Saidu Sharif reference :contentReference[oaicite:63]{index=63}
    "Tando Adam": {"lat": 26.2, "lng": 68.0}, // estimated
    "Tando Allahyar": {"lat": 25.45, "lng": 68.72}, // estimated
    "Taxila": {"lat": 33.743, "lng": 72.799}, // not found explicitly
    "Thatta": {
      "lat": 24.749731,
      "lng": 67.911636
    }, // :contentReference[oaicite:64]{index=64}
    "Toba Tek Singh": {
      "lat": 30.97,
      "lng": 72.43
    }, // :contentReference[oaicite:65]{index=65}
    "Turbat": {
      "lat": 26.004168,
      "lng": 63.060555
    }, // :contentReference[oaicite:66]{index=66}
    "Vehari": {
      "lat": 30.045246,
      "lng": 72.348869
    }, // :contentReference[oaicite:67]{index=67}
    "Wah Cantt": {
      "lat": 33.783184,
      "lng": 72.723076
    }, // :contentReference[oaicite:68]{index=68}
    "Zhob": {"lat": 31.333333, "lng": 69.450}, // estimated
    "Ziarat": {"lat": 30.383333, "lng": 67.716667}, // estimated
  };

  @override
  void initState() {
    super.initState();
    // rebuildPage();
    // Delay showing the message for 10 seconds
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size * 1;

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to discard post?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    var pro = context.read<FireStoreProvider>();
                    pro.isLoading = false;

                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          title: Text(
            "Include some details",
            style: AppTextStyles.textStyleBoldBodyMedium,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Builder(builder: (context) {
              var provider = context.watch<FireStoreProvider>();
              return provider.isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomLoader(),
                        Text(
                          "Please Wait ......",
                          style: AppTextStyles.textStyleBoldBodyMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        // CustomContainer(
                        //   text: "Include some details",
                        //   iconVar: Icons.arrow_back_ios,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "UPLOAD UP TO 10 PHOTOS",
                                    style: AppTextStyles.textStyleBoldBodySmall,
                                  ),
                                  const Spacer(),
                                  selectedImages.isNotEmpty &&
                                          selectedImages.length <= 9
                                      ? InkWell(
                                          onTap: () {
                                            GetImages();
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppColors.blue),
                                            child: const Center(
                                              child: Icon(
                                                Icons.photo_camera,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const Text(""),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              selectedImages.isEmpty
                                  ? InkWell(
                                      onTap: () async {
                                        GetImages();
                                      },
                                      child: Container(
                                          height: 180.0,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColors.blue),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.photo_camera,
                                                    color: AppColors.primary,
                                                    size: 50,
                                                  ),
                                                ],
                                              ),
                                             const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [],
                                              )
                                            ],
                                          )),
                                    )
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          for (int i = 0;
                                              i < selectedImages.length;
                                              i++)
                                            InkWell(
                                              onTap: () {
                                                push(
                                                    context,
                                                    ImageScreen(
                                                        imagePath:
                                                            selectedImages[i]));
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                height: 100,
                                                width: 100,
                                                child: Image.file(
                                                  selectedImages[i],
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Category",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              widget.link != null
                                  ? CustomListTile(
                                      tap: () {
                                        push(context, RootScreen());
                                      },
                                      back_color: widget.color,
                                      circular_radius: 30.0,
                                      circularwidget: Container(
                                          height: 65.0,
                                          width: 65.0,
                                          child: Center(
                                              child: Image(
                                            image: AssetImage(widget.link),
                                            fit: BoxFit.cover,
                                          ))),
                                      titletext: widget.titletext,
                                      titleStyle:
                                          AppTextStyles.textStyleBoldBodyMedium,
                                      subtitleText: widget.subtext,
                                      subtitleStyle:
                                          AppTextStyles.textStyleSubtitleBody)
                                  : const Text("Null"),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Price",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      isFree = true;
                                      setState(() {});
                                    },
                                    child: CustomContainerText(
                                      style: isFree
                                          ? AppTextStyles
                                              .textStyleNormalBodySmall
                                              .copyWith(color: AppColors.white)
                                          : null,
                                      container_color:
                                          isFree ? AppColors.blue : null,
                                      text: "Free",
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      isFree = false;
                                      setState(() {});
                                    },
                                    child: CustomContainerText(
                                      style: isFree == false
                                          ? AppTextStyles
                                              .textStyleNormalBodySmall
                                              .copyWith(color: AppColors.white)
                                          : null,
                                      container_color: isFree == false
                                          ? AppColors.blue
                                          : null,
                                      text: "Price",
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (isFree == false)
                                CustomTextField(
                                  keyboardtype: TextInputType.number,
                                  controller: priceController,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: AppColors.grey)),
                                  hintText: "RS:",
                                  obsecuretext: false,
                                  width: size.width,
                                ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(
                                height: 20,
                              ),
                              // Text(
                              //   "Gender",
                              //   style: AppTextStyles.textStyleBoldBodySmall,
                              // ),
                              // const SizedBox(
                              //   height: 05,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         selected = "first";
                              //         setState(() {});
                              //       },
                              //       child: CustomContainerText(
                              //         style: selected == "first"
                              //             ? AppTextStyles.textStyleNormalBodySmall
                              //                 .copyWith(color: AppColors.white)
                              //             : null,
                              //         container_color:
                              //             selected == "first" ? AppColors.blue : null,
                              //         text: "Male",
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       width: 10,
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //         selected = "second";
                              //         setState(() {});
                              //       },
                              //       child: CustomContainerText(
                              //         style: selected == "second"
                              //             ? AppTextStyles.textStyleNormalBodySmall
                              //                 .copyWith(color: AppColors.white)
                              //             : null,
                              //         container_color:
                              //             selected == "second" ? AppColors.blue : null,
                              //         text: "Female",
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       width: 10,
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // const Divider(),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // Text(
                              //   "Age",
                              //   style: AppTextStyles.textStyleBoldBodySmall,
                              // ),
                              // const SizedBox(
                              //   height: 05,
                              // ),
                              // CustomTextField(
                              //   keyboardtype: TextInputType.number,
                              //   controller: ageController,
                              //   border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(20),
                              //       borderSide: BorderSide(color: AppColors.grey)),
                              //   hintText: "Years 1 - 2",
                              //   obsecuretext: false,
                              //   width: size.width,
                              // ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // const Divider(),
                              // const SizedBox(
                              //   height: 20,
                              // ),

                              Consumer<AuthProvider>(
                                builder: (context, pro, child) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Location",
                                        style: AppTextStyles
                                            .textStyleTitleBodySmall,
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                          ),
                                          child: DropdownButton<String>(
                                            value:
                                                citiesCoordinates.containsKey(
                                                        pro.currentAddress)
                                                    ? pro.currentAddress
                                                    : null,
                                            hint: const Text("Choose a city"),
                                            isExpanded: true,
                                            underline: const SizedBox(),
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            items: citiesCoordinates.keys
                                                .map((city) {
                                              return DropdownMenuItem<String>(
                                                value: city,
                                                child: Text(city),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              if (value != null) {
                                                pro.setAddress(value);
                                                final lat = citiesCoordinates[
                                                    value]!["lat"];
                                                final lng = citiesCoordinates[
                                                    value]!["lat"];

                                                print(
                                                    "Selected city: $value, Lat: $lat, Lng: $lng");

                                                pro.setlatnadlng(lat, lng);
                                              }
                                            },
                                          )),
                                    ],
                                  );
                                },
                              ),

                              // Consumer<AuthProvider>(

                              //     builder: (context, pro,child) {

                              //     return  GestureDetector(
                              //     onTap: () async {

                              //       pro.Location(context);
                              //     },
                              //     child: Builder(builder: (context) {
                              //       // var pro = context.read<AuthProvider>();
                              //       return CutomListTileUser(
                              //         title_text: "Location",
                              //         title_style:
                              //             AppTextStyles.textStyleTitleBodySmall,
                              //         subtitle_text: pro.currentAddress != Null
                              //             ? pro.currentAddress
                              //             : "Choose",
                              //         subtitle_style:
                              //             AppTextStyles.textStyleSubtitleBody,
                              //         trailing_widget: const Icon(
                              //           Icons.arrow_forward_ios,
                              //           color: Color(0xfa000000),
                              //           size: 20,
                              //         ),
                              //       );
                              //     }),
                              //   );}
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Add title*",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                              const SizedBox(
                                height: 05,
                              ),
                              CustomTextField(
                                keyboardtype: TextInputType.text,
                                controller: titlleController,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: AppColors.grey)),
                                hintText: "Title",
                                obsecuretext: false,
                                width: size.width,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Describe what you are selling*",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                              const SizedBox(
                                height: 05,
                              ),
                              CustomTextField(
                                keyboardtype: TextInputType.multiline,
                                controller: describeController,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: AppColors.grey)),
                                hintText: "Selling",
                                obsecuretext: false,
                                width: size.width,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 40,
                              ),
                              CustomButton(
                                onTap: () async {
                                  if (titlleController.text.isEmpty) {
                                    showSnack(
                                        context: context,
                                        text: "Enter Please Title Field");
                                  } else if (describeController.text.isEmpty) {
                                    showSnack(
                                        context: context,
                                        text: "Enter Please Description Field");
                                  } else if (!isFree &&
                                      priceController.text.isEmpty) {
                                    showSnack(
                                        context: context,
                                        text: "Please Enter Price Field");
                                  } else {
                                    if (selectedImages.isNotEmpty) {
                                      var comp =
                                          context.read<CompressProvider>();
                                      await comp.compressImages(selectedImages);
                                      String datetime =
                                          DateTime.now().toString();
                                      var data =
                                          context.read<FireStoreProvider>();

                                       var auth =  context.read<AuthProvider>();   
                                      // debugger();
                                      await data.addImage(
                                        selectedImages:
                                            selectedImages, // Pass an empty list to not post any images
                                        price: priceController.text,
                                        age: ageController.text,
                                        title: titlleController.text,
                                        description: describeController.text,
                                        category: widget.titletext,
                                        subcategory: widget.subtext,
                                        isFree: isFree,
                                        dateTime: datetime,
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid,
                                      lat: auth.lats,
                                      lng: auth.lngs,
                                      currentAdress : auth.currentAddress
                                        // categoryID: "",
                                        // subcategoryID:"",

                                        // itemAddress: "",

                                        // ownerID:ownerID,
                                        // itemLocation:""
                                      );
                                      FocusScope.of(context).nextFocus();
                                      // uploadImage(selectedImages);
                                      push(context, RootScreen());
                                    } else {
                                      showSnack(
                                          context: context,
                                          text: "Please! Select Images!");
                                    }
                                  }
                                },
                                text: "Post Now",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }

  // getImages() async {
  //   final pickedFile = await picker.pickMultiImage(imageQuality: 25);
  //   List<XFile> xfilePick = pickedFile;
  //   if (xfilePick.isNotEmpty) {
  //     for (var i = 0; i < xfilePick.length; i++) {
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
  //   }
  // }

  GetImages() async {
    final pickedFile = await picker.pickMultiImage(
      imageQuality: 25,
    );
    List<XFile> xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            File selected = File(xfilePick[i].path);
            selectedImages.add(selected);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
  // final result = await FlutterImageCompress.compressAndGetFile(
  //   image.path,
  //   image.path,
  //   quality: 75, // Adjust the quality as needed
  // );

  // if (result != null) {
  //   return result;
  // } else {
  //   throw 'Image compression failed'; // You can customize this error message
  // }
// }
}
