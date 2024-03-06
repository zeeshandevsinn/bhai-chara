// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bhai_chara/controller/provider/notification_provider.dart';
import 'package:bhai_chara/controller/provider/product/product_detail.dart';
import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
import 'package:bhai_chara/controller/services/shared_prefrences.dart';
import 'package:bhai_chara/model/user_model.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:bhai_chara/utils/refresh.dart';
import 'package:bhai_chara/view/authentication/signup_screen_by_phone.dart';
import 'package:bhai_chara/view/settings-screens/dialogBox.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bhai_chara/common/custom_button.dart';
import '../../utils/app_colors.dart';
import '../../utils/text-styles.dart';
import '../../utils/utils.dart';
import 'mapScreen.dart';

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  ProductScreen({super.key, this.id});
  var id;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper.instance();

  @override
  void initState() {
    super.initState();
    fetchUserData();
    ProductDetailProvider provider = context.read<ProductDetailProvider>();
    // debugger();
    provider.getProductDetail(context, widget.id).then((val) {
      provider.getRequestedProduct(widget.id);
    });
  }

  UserModel? userData;

  void fetchUserData() async {
    UserModel? userData = await _sharedPreferenceHelper.user();
    setState(() {
      userData = userData;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Consumer<ProductDetailProvider>(
              builder: (context, provider, child) {
            return provider.isLoading
                ? const Center(child: CustomLoader())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        // value = widget.index,
                        CarouselSlider.builder(
                          carouselController: CarouselController(),
                          options: CarouselOptions(
                            height: 300,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            // onPageChanged:,
                            scrollDirection: Axis.horizontal,
                          ),
                          itemCount:
                              provider.productDetailModel!.urlImage!.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              Container(
                            height: 300,
                            width: double.infinity,
                            child: Image(
                              image: NetworkImage(provider
                                  .productDetailModel!.urlImage![itemIndex]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Color.fromARGB(255, 223, 81, 15),
                                    size: 35,
                                  )),
                              // IconButton(
                              //     onPressed: () {},
                              //     icon: Icon(
                              //       Icons.forward,
                              //       color: widget.index == null
                              //           ? AppColors.black
                              //           : Color.fromARGB(255, 223, 81, 15),
                              //     ))
                            ],
                          ),
                        )
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 25),
                        child: provider.productDetailModel?.isFree == true
                            ? const Text("Free")
                            : Row(
                                children: [
                                  Text(
                                    "Rs: ",
                                    style:
                                        AppTextStyles.textStyleBoldBodyMedium,
                                  ),
                                  Text(
                                    provider.productDetailModel?.price ?? '',
                                    style:
                                        AppTextStyles.textStyleBoldBodyMedium,
                                  ),
                                ],
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 8),
                        child: Text(
                          provider.productDetailModel!.category!,
                          style: AppTextStyles.textStyleBoldBodySmall.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 25, right: 20),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 30,
                            ),
                            const Spacer(),
                            Text(
                              " ${DateFormat("dd-MMM-yyyy hh:mm a").format(DateTime.parse(provider.productDetailModel!.time!))}",
                              style: AppTextStyles.textStyleNormalBodyXSmall,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 25),
                        child: Text(
                          'Details',
                          style: AppTextStyles.textStyleBoldBodySmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Brand:',
                                  style: AppTextStyles.textStyleBoldBodySmall
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.productDetailModel!.subcategory!,
                                    style: AppTextStyles.textStyleBoldBodySmall
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 25),
                        child: Text(
                          'Description',
                          style: AppTextStyles.textStyleBoldBodySmall,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 8, bottom: 10),
                        child: Text(
                          provider.productDetailModel!.description!,
                          style: AppTextStyles.textStyleBoldBodySmall.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(provider.donnerDetail!.image!),
                        ),
                        title: Text(provider.donnerDetail?.name ?? '',
                            style: AppTextStyles.textStyleBoldBodySmall
                                .copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                        subtitle: Text(
                          "Joined Since ${DateFormat("dd-MMM-yyyy").format(DateTime.parse(provider.donnerDetail!.createdTime.toString()))}",
                          style: AppTextStyles.textStyleNormalBodySmall,
                        ),
                      ),

                      const Divider(),

                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 25),
                        child: Text(
                          'Location',
                          style: AppTextStyles.textStyleBoldBodySmall,
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      //   child: Row(
                      //     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Icon(
                      //         Icons.location_on_outlined,
                      //         size: 30,
                      //       ),
                      //       // Builder(builder: (context) {
                      //       //   var loc2 = context.watch<AuthProvider>();
                      //       //   return Container(
                      //       //       width: 180,
                      //       //       child: Text(
                      //       //         loc2.currentAddress,
                      //       //         style: AppTextStyles.textStyleBoldBodySmall
                      //       //             .copyWith(
                      //       //           fontSize: 16,
                      //       //           fontWeight: FontWeight.bold,
                      //       //         ),
                      //       //       ));
                      //       // }),
                      //     ],
                      //   ),
                      // ),

                      Container(
                        height: 190,
                        width: double.infinity,
                        child: InkWell(
                            onTap: () {
                              push(context, const MapScreen());
                            },
                            child: GoogleMap(
                              myLocationButtonEnabled: true,
                              myLocationEnabled: true,
                              mapType: MapType.normal,
                              markers: Set.from(provider.markersData),
                              initialCameraPosition: CameraPosition(
                                  zoom: 14,
                                  target: LatLng(
                                    provider.donnerDetail!.lat!.toDouble(),
                                    provider.donnerDetail!.long!.toDouble(),
                                  )),
                              onMapCreated: (GoogleMapController controller) {
                                // bloc.googleMapController
                                //     .complete(controller);
                              },
                            )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 8),
                        child: Text('Your safety matters to us!',
                            style: AppTextStyles.textStyleBoldBodySmall
                                .copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                      ),
                      // Wrap the UnorderedList with a ListView
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          'Only meet in public / crowded places',
                          'Never go alone to meet a buyer / seller, always take someone with you.',
                          'Check and inspect the product properly before purchasing it.',
                          'Never pay anything in advance or transfer money before inspecting the product.',
                        ]
                            .map((item) => Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 3,
                                          backgroundColor: AppColors.black,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: SizedBox(
                                          width: 280,
                                          child: Text(
                                            item,
                                            softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),

                      // CustomList(text: "Only meet in public / crowded places"),
                      // CustomList(text: "Never go alone to meet a buyer / seller, always take someone with you."),
                      // CustomList(text: "Check and inspect the product properly before purchasing it."),
                      // CustomList(text: "Never pay anything in advance or transfer money before inspecting the product."),
                      if (FirebaseAuth.instance.currentUser?.uid !=
                          provider.productDetailModel!.uid)
                        if (provider.isProductRequested)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already Requested",
                                  style: AppTextStyles
                                      .textStyleNormalBody_BlueColor,
                                ),
                              ],
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Consumer<ProductDetailProvider>(
                                builder: (context, p, child) {
                              return isLoading
                                  ? const CustomLoader()
                                  : CustomButton(
                                      onTap: () async {
                                        isLoading = true;
                                        setState(() {});

                                        var uid = FirebaseAuth
                                            .instance.currentUser!.uid;
                                        UserModel? user =
                                            await firebaseGetUserDetail(uid);
                                        isLoading = false;
                                        setState(() {});
                                        if (user?.isPhoneVerified == true) {
                                          await provider.addRequest(context,
                                              productID: widget.id, user: user);

                                          String token =
                                              provider.donnerDetail!.fcmToken!;
                                          NotificationProvider.sendNotification(
                                              token: token,
                                              message:
                                                  "${userData!.name} New Request For Donation");
                                          NotificationProvider.sendPushMessage(
                                              token);
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ErrorDialogBox(
                                                  title:
                                                      "Verification Required!",
                                                  descrption:
                                                      "Please Verify your Phone Number",
                                                  buttonText: "GO",
                                                  onTap: () {
                                                    pop(context);
                                                    push(context,
                                                        const SignUpScreenByPhone());
                                                  },
                                                );
                                              });
                                          // showSnack(
                                          //     context: context,
                                          //     text: "Please Verify your Phone Number");
                                        }
                                      },
                                      text: "Request",
                                    );
                            }),
                          ),

                      // SizedBox(
                      //     height: 20,
                      //   ),
                    ],
                  );
          }),
        ),
      ),
    );
  }

  // ignore: unu
}
