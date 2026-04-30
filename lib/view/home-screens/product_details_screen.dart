// ignore_for_file: use_build_context_synchronously

import 'package:bhai_chara/controller/provider/product/product_detail.dart';
import 'package:bhai_chara/controller/services/Firebase_Manager.dart';

import 'package:bhai_chara/model/product_detail_model.dart';
import 'package:bhai_chara/model/user_model.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bhai_chara/common/custom_button.dart';
import '../../controller/provider/authentication_provider/auth_provider.dart';
import '../../stripeservices/paymentservice.dart';
import '../../utils/app_colors.dart';
import '../../utils/showSnack.dart';
import '../../utils/text-styles.dart';
import '../../utils/utils.dart';
import '../authentication/signup_screen_by_phone.dart';
import '../settings-screens/dialogBox.dart';
import 'mapScreen.dart';

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  ProductScreen(
      {super.key, this.id, this.userid, this.where, this.currentuserid});
  var id;
  var userid;
  String? where;
  String? currentuserid;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // final SharedPreferenceHelper _sharedPreferenceHelper =
  //     SharedPreferenceHelper.instance();
  StripePaymentservices paymentservices = StripePaymentservices();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final provider = context.read<ProductDetailProvider>();

      await provider.getProductDetail(context, widget.id);

      if (!mounted) return;

      provider.getRequestedProduct(widget.id);
      provider.isProductFavourite(widget.id);
    });
  }

  // UserModel? userData;

  // void fetchUserData() async {
  //   UserModel? userData = await _sharedPreferenceHelper.user();
  //   setState(() {
  //     userData = userData;
  //   });
  // }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductDetailProvider>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
            child: provider.isLoading || provider.productDetailModel == null
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
                              provider.productDetailModel?.urlImage?.length ??
                                  1,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl: provider.productDetailModel
                                      ?.urlImage?[itemIndex] ??
                                  'https://www.google.com/imgres?q=cat&imgurl=https%3A%2F%2Fi.natgeofe.com%2Fn%2F548467d8-c5f1-4551-9f58-6817a8d2c45e%2FNationalGeographic_2572187_16x9.jpg%3Fw%3D1200&imgrefurl=https%3A%2F%2Fwww.nationalgeographic.com%2Fanimals%2Fmammals%2Ffacts%2Fdomestic-cat&docid=K6Qd9XWnQFQCoM&tbnid=VCezPSgAAsDM2M&vet=12ahUKEwjE5t3nktiOAxUI6wIHHb-RHnoQM3oECAwQAA..i&w=1200&h=675&hcb=2&ved=2ahUKEwjE5t3nktiOAxUI6wIHHb-RHnoQM3oECAwQAA',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.broken_image, size: 40),
                            ),
                          ),
                        ),
                        widget.where == 'no'
                            ? Positioned(
                                right: 10,
                                top: 10,
                                child: InkWell(
                                    onTap: () {
                                      ProductDetailModel product =
                                          ProductDetailModel(
                                        isFree:
                                            provider.productDetailModel!.isFree,
                                        time: provider.productDetailModel!.time,
                                        title:
                                            provider.productDetailModel!.title,
                                        uid: provider.productDetailModel!.uid,
                                        category: provider
                                            .productDetailModel!.category,
                                        description: provider
                                            .productDetailModel!.description,
                                        urlImage: provider
                                            .productDetailModel!.urlImage,
                                        subcategory: provider
                                            .productDetailModel!.subcategory,
                                        age: provider.productDetailModel!.age,
                                        price:
                                            provider.productDetailModel!.price,
                                        currentLocation: provider
                                            .productDetailModel!
                                            .currentLocation,
                                      );

                                      provider.toggleFavourite(
                                          product, widget.id);
                                    },
                                    child: provider.isfavourite
                                        ? const Icon(Icons.favorite_outlined)
                                        : const Icon(
                                            Icons.favorite_border,
                                            size: 35,
                                          )),
                              )
                            : const SizedBox(),
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
                          provider.productDetailModel?.category ?? 'category',
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
                        // leading: CircleAvatar(
                        //   backgroundImage:
                        //       NetworkImage(provider.donnerDetail!.image!),
                        // ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 30,
                            ),
                            Builder(builder: (context) {
                              var loc2 = context.watch<AuthProvider>();
                              return Container(
                                  width: 180,
                                  child: Text(
                                    "Pakistan, ${provider.productDetailModel!.currentLocation} ",
                                    style: AppTextStyles.textStyleBoldBodySmall
                                        .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ));
                            }),
                          ],
                        ),
                      ),

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
                                    // provider.productDetailModel!.lat!.toDouble(),
                                    // provider.productDetailModel!.lng!.toDouble(),
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
                          Consumer<ProductDetailProvider>(
                            builder: (context, p, _) {
                              return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: p.isloading
                                      ? const CustomLoader()
                                      : CustomButton(
                                          onTap: () async {
                                            p.setbool(true);
                                            // isLoading = true;
                                            // setState(() {});

                                            var uid = FirebaseAuth
                                                .instance.currentUser!.uid;
                                            UserModel? user =
                                                await firebaseGetUserDetail(
                                                    uid);
                                            p.setbool(false);
                                            // isLoading = false;
                                            // setState(() {});
                                            if (user?.isPhoneVerified == true) {
                                              bool paymentSuccess =
                                                  await paymentservices
                                                      .makePayment(
                                                          context, '100');

                                              if (!paymentSuccess) {
                                                // Stop execution if payment failed
                                                return;
                                              }
                                              await p.addRequest(context,
                                                  productID: widget.id,
                                                  user: user,
                                                  idofuser: widget.userid);
                                              // 🔽 Create Chat Room and Default Message

                                              // String token =
                                              //     provider.donnerDetail!.fcmToken!;
                                              // NotificationProvider.sendNotification(
                                              //     token: token,
                                              //     message:
                                              //         "${userData!.name} New Request For Donation");
                                              // NotificationProvider.sendPushMessage(
                                              //     token);
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
                                                        push(
                                                            context,
                                                            SignUpScreenByPhone(
                                                              userid: widget
                                                                  .currentuserid
                                                                  .toString(),
                                                            ));
                                                      },
                                                    );
                                                  });
                                              showSnack(
                                                  context: context,
                                                  text:
                                                      "Please Verify your Phone Number");
                                            }
                                          },
                                          text: "Request",
                                        ));
                            },
                          ),

                      // SizedBox(
                      //     height: 20,
                      //   ),
                    ],
                  )),
      ),
    );
  }

  // ignore: unu
}
