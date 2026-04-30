// ignore_for_file: unnecessary_null_comparison, unused_local_variable, duplicate_ignore
import 'package:bhai_chara/chatt/chat_list_screen.dart';
import 'package:bhai_chara/common/custom_container_tile.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/app_config.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:bhai_chara/view/home-screens/product_details_screen.dart';
import 'package:bhai_chara/view/home-screens/root_screen.dart';
import 'package:bhai_chara/view/home-screens/search_deligate.dart';
import 'package:bhai_chara/view/home-screens/sell_sub_categorie_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/custom_container_children.dart';
import '../../controller/provider/authentication_provider/auth_provider.dart';
import '../../controller/provider/priceprovider/select_type_provider.dart';
import '../../utils/circle_avatar.dart';
import '../../utils/container_with_img.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  TextEditingController searchController = TextEditingController();
  List<Color> colorList = [
    AppColors.orange,
    AppColors.yellow,
    AppColors.Green,
    AppColors.pink,
    AppColors.blue,
    AppColors.Green,
  ];
  List<String> sellCategory = [
    "Animal",
    "Electronic",
    "Mobile",
    "Furniture",
    "Bike",
    "Car",
  ];
  List<String> screens = [
    'assets/images/fluent_animal-cat-28-filled.png',
    'assets/images/basil_camera-solid.png',
    'assets/images/fontisto_mobile.png',
    'assets/images/map_furniture-store.png',
    'assets/images/ri_motorbike-fill.png',
    'assets/images/colorcar.png'
  ];

  // var selected = "All";

  @override
  void initState() {
    var pro = context.read<AuthProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      String currentAddress = "";
      pro.Location(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              const Text(
                'Bhai Chara',
                style: TextStyle(color: Colors.black),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatListScreen(),
                      ));
                },
                child: const Icon(
                  Icons.chat,
                  size: 24,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     context.read<AuthProvider>().Location(context);
        //     // String? token = await FirebaseMessaging.instance.getToken();
        //     // log(" ${token}");
        //     // token =
        //     //     'dyOye8eFRN-jw8YMTLr_LG:APA91bEKwtOPiwqcimjXgV8ABnfiYfxDv2pdxxboC_NhLOxPG7Y12tqzXb6SZZR6Hd_WitEx9VUwpdaZwNkB7-Upji0O7SAVd1AMXYlvTpOAm2nRFckU6vDJDPxB6UO_up88yWU_AM6b';
        //     // NotificationProvider.sendNotification(
        //     //     token: token!, message: "Test notification");
        //     // NotificationProvider.sendPushMessage(token);
        //   },
        // ),
        backgroundColor: AppColors.white,
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
              () {
                RootScreen();
                // setState(() {
                //   push(context,RootScreen() );
                // });
              },
            );
          },
          child: Builder(builder: (context) {
            // ignore: unused_local_variable
            var pro = context.watch<AuthProvider>();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 10,
                  //   ),
                  //   height: 80,
                  //   width: double.infinity,
                  //   decoration: const BoxDecoration(color: AppColors.App),
                  //   child: Row(
                  //     children: [
                  //       const Image(
                  //         image:
                  //             AssetImage('assets/images/Bhai Chara svg 1.png'),
                  //         height: 45,
                  //         width: 45,
                  //       ),
                  //       const Spacer(),

                  //       /// Popup menu icon (vertical dot)
                  //       // PopupMenuButton<String>(
                  //       //   color: AppColors.black,
                  //       //   icon: const Icon(Icons.more_vert,
                  //       //       color: AppColors.primary),
                  //       //   onSelected: (value) async {
                  //       //     if (value == 'location') {
                  //       //       final pro = context.read<AuthProvider>(N);
                  //       //       await pro.Location(context);
                  //       //     }
                  //       //   },
                  //       //   itemBuilder: (BuildContext context) => [
                  //       //     PopupMenuItem<String>(
                  //       //       value: 'location',
                  //       //       child: Column(
                  //       //         mainAxisAlignment: MainAxisAlignment.center,
                  //       //         children: [
                  //       //           const Icon(Icons.my_location_outlined,
                  //       //               size: 24, color: AppColors.primary),
                  //       //           pro.isLoading
                  //       //               ? Container(
                  //       //                   // height: 40,
                  //       //                   width: 80,
                  //       //                   child: const CustomLoader())
                  //       //               : pro.currentAddress.isEmpty
                  //       //                   ? MaterialButton(
                  //       //                       shape: RoundedRectangleBorder(
                  //       //                           borderRadius:
                  //       //                               BorderRadius.circular(
                  //       //                                   20)),
                  //       //                       color: AppColors.black,
                  //       //                       onPressed: () async {
                  //       //                         pro = context
                  //       //                             .read<AuthProvider>();
                  //       //                         String currentAddress = "";
                  //       //                         await pro.Location(context);
                  //       //                       },
                  //       //                       child: const Text(
                  //       //                         "Location",
                  //       //                         style: TextStyle(
                  //       //                             fontSize: 15,
                  //       //                             fontWeight:
                  //       //                                 FontWeight.w500,
                  //       //                             color: AppColors.primary),
                  //       //                         textAlign: TextAlign.center,
                  //       //                       ))
                  //       //                   : Text(
                  //       //                       pro.currentAddress,
                  //       //                       style: const TextStyle(
                  //       //                           fontSize: 15,
                  //       //                           fontWeight: FontWeight.w500,
                  //       //                           color: AppColors.primary),
                  //       //                       textAlign: TextAlign.center,
                  //       //                     )
                  //       //         ],
                  //       //       ),
                  //       //     ),
                  //       //   ],
                  //       // ),

                  //       InkWell(
                  //         onTap: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) => const ChatListScreen(),
                  //               ));
                  //         },
                  //         child: const Icon(
                  //           Icons.chat,
                  //           size: 24,
                  //           color: AppColors.white,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    color: AppColors.white,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: CustomTextField(
                        onTap: () async {
                          await showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(),
                          );
                        },
                        prfixicon: const Icon(Icons.search),
                        prefixcolor: AppColors.Grey,
                        controller: searchController,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "What are you looking for?",
                        obsecuretext: false),
                  ),
                  Container(
                    height: AppConfig(context).height,
                    color: AppColors.white,
                    child: Column(
                      children: [
                        Container(
                          height: AppConfig(context).height,
                          color: AppColors.white,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 255),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20, top: 15),
                                      child: Text(
                                        'Browse Categories',
                                        style: AppTextStyles
                                            .textStyleBoldBodyMedium,
                                      )),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (int i = 0;
                                            i < sellCategory.length;
                                            i++)
                                          CustomCircleAvatar(
                                            ontap: () {
                                              push(
                                                  context,
                                                  SubCategorieScreen(
                                                    link: screens[i],
                                                    color: colorList[i],
                                                    text: sellCategory[i],
                                                  ));
                                            },
                                            link: screens[i],
                                            col: colorList[i],
                                            txt: sellCategory[i],
                                          ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20, top: 15),
                                      child: Text(
                                        'Latest',
                                        style: AppTextStyles
                                            .textStyleBoldBodyMedium,
                                      )),
                                  Consumer<SelectedType>(
                                    builder: (context, select, _) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  select.setSelectedtype("All");
                                                  // selected = "All";
                                                  // setState(() {});
                                                },
                                                child: CustomContainerText(
                                                  style: select.selected ==
                                                          "All"
                                                      ? AppTextStyles
                                                          .textStyleNormalBodySmall
                                                          .copyWith(
                                                              color: AppColors
                                                                  .white)
                                                      : AppTextStyles
                                                          .textStyleNormalBodyXSmall
                                                          .copyWith(
                                                              color: AppColors
                                                                  .black),
                                                  container_color:
                                                      select.selected == "All"
                                                          ? AppColors.black
                                                          : null,
                                                  text: "All",
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  select
                                                      .setSelectedtype("Free");
                                                  // selected = "Free";
                                                  // setState(() {});
                                                },
                                                child: CustomContainerText(
                                                  style: select.selected ==
                                                          "Free"
                                                      ? AppTextStyles
                                                          .textStyleNormalBodySmall
                                                          .copyWith(
                                                              color: AppColors
                                                                  .white)
                                                      : AppTextStyles
                                                          .textStyleNormalBodyXSmall
                                                          .copyWith(
                                                              color: AppColors
                                                                  .black),
                                                  container_color:
                                                      select.selected == "Free"
                                                          ? AppColors.black
                                                          : null,
                                                  text: "Free",
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  select
                                                      .setSelectedtype("Paid");
                                                  // selected = "Paid";
                                                  // setState(() {});
                                                },
                                                child: CustomContainerText(
                                                  style: select.selected ==
                                                          "Paid"
                                                      ? AppTextStyles
                                                          .textStyleNormalBodySmall
                                                          .copyWith(
                                                              color: AppColors
                                                                  .white)
                                                      : AppTextStyles
                                                          .textStyleNormalBodyXSmall
                                                          .copyWith(
                                                              color: AppColors
                                                                  .black),
                                                  container_color:
                                                      select.selected == "Paid"
                                                          ? AppColors.black
                                                          : null,
                                                  text: "Paid",
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection("Products")
                                                .where("uid",
                                                    isNotEqualTo: FirebaseAuth
                                                        .instance
                                                        .currentUser
                                                        ?.uid)
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.hasData) {
                                                QuerySnapshot data =
                                                    snapshot.data;

                                                List<DocumentSnapshot>
                                                    filteredData = [];

                                                for (int index = 0;
                                                    index < data.docs.length;
                                                    index++) {
                                                  DocumentSnapshot dataDoc =
                                                      data.docs[index];
                                                  bool isFree =
                                                      dataDoc.get('isFree');
                                                  print('is freee: $isFree');
                                                  if (select.selected ==
                                                          "All" ||
                                                      (select.selected ==
                                                              "Free" &&
                                                          isFree) ||
                                                      (select.selected ==
                                                              "Paid" &&
                                                          !isFree)) {
                                                    filteredData.add(dataDoc);
                                                  }
                                                }

                                                return GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      filteredData.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    DocumentSnapshot dataDoc =
                                                        filteredData[index];

                                                    return CustomContainerBox(
                                                      isfree:
                                                          dataDoc.get('isFree'),
                                                      text:
                                                          dataDoc.get('title'),
                                                      secondText: dataDoc
                                                          .get('description'),
                                                      imgLink: dataDoc
                                                          .get('urlImage')[0],
                                                      ontap: () {
                                                        push(
                                                          context,
                                                          ProductScreen(
                                                              where: 'no',
                                                              userid: dataDoc
                                                                  .get('uid'),
                                                              id: dataDoc.id,
                                                              currentuserid:
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid),
                                                        );
                                                      },
                                                    );
                                                  },

                                                  // ignore: prefer_const_constructors
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          childAspectRatio:
                                                              .85),
                                                );
                                              } else if (snapshot
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child: CustomLoader());
                                              } else {
                                                return const Center(
                                                    child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 100),
                                                  child: Text(
                                                      'No Products to Show'),
                                                ));
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Gap.h(50),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
