import 'package:bhai_chara/utils/app_config.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/custom_order_container.dart';
import '../controller/provider/product/status.dart';
import '../controller/services/Firebase_Manager.dart';
import '../utils/app_colors.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.white,
            title: Text(
              "Requests",
              style: AppTextStyles.textStyleBoldBodyMedium,
            ),
            centerTitle: true,
            bottom: const TabBar(
              labelColor: AppColors.blue,
              tabs: [
                Tab(text: "Pending"),
                Tab(text: "Approved"),
                Tab(text: "Rejected"),
              ],
            ),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.h(10),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('requests')
                          .where("uid",
                              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                          .where("request",
                              isEqualTo: 'pending')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Center(
                                child: Text(
                                  "${snapshot.data.docs.length} New Requests",
                                  //  "${1} New Requests",
                                  //textAlign: TextAlign.center,
                                  style: AppTextStyles
                                      .textStyleNormalBody_BlueColor,
                                ),
                              ),
                              ListView.builder(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  // itemCount: 1,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    var request = snapshot.data.docs[index];
                                    return 
                                    
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: 
                                      
                                      // OrderContainer(
                                      //   status: ProductStatus.pending.name,
                                      //   receiverEmail: "john.doe@example.com",
                                      //   receiverPhone: "+1234567890",
                                      //   receiverImage:
                                      //       "assets/images/car_product.png", // use your local image or URL
                                      //   receiverName: "John Doe",
                                      //   receiverID: "user123",
                                      //   uid: "order456",
                                      //   text: "Sample Product Title",
                                      //   color1: AppColors.grey,
                                      //   color2: AppColors.blue,
                                      //   isFree: false,
                                      //   address:
                                      //       "123 Rainbow Street, WonderTown",
                                      //   price: "Price:\t\t\t\$25.00",
                                      //   time:
                                      //       "Time:\t\t\t\t17-Jun-2025 04:45 PM", // manually formatted string
                                      // ),

                                      OrderContainer(
                                          status: ProductStatus.pending.name,
                                          receiverEmail:
                                              request.get("requester_email"),
                                          receiverPhone:
                                              request.get("requester_phone"),
                                          receiverImage:
                                              request['urlImage'][0],
                                          receiverName:
                                              request.get("requester_name"),
                                          receiverID:
                                              request.get("requester_id"),
                                          uid: request.id,
                                          text: request.get("title"),
                                          color1: AppColors.grey,
                                          color2: AppColors.blue,
                                          isFree: request.get("isFree"),
                                          address:
                                              request.get("requester_address"),
                                          price:
                                              "Price:\t\t\t${request.get("price")}",
                                          time:
                                              "Time:\t\t\t\t${DateFormat("d-MMM-yyyy mm:ss a").format(request.get("request_time").toDate())}"),
                                    );
                                  }),
                            ],
                          );
                        }

                        return CustomLoader();
                      }),
                  Gap.h(80),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.h(10),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(REQUEST_COLLECTION)
                          .where("uid",
                              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                          .where("request",
                              isEqualTo: ProductStatus.approved.name)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Center(
                                child: Text(
                                  "${snapshot.data.docs.length} Approved Requests",
                                  //textAlign: TextAlign.center,
                                  style: AppTextStyles
                                      .textStyleNormalBody_BlueColor
                                      .copyWith(color: AppColors.Green),
                                ),
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    var request = snapshot.data.docs[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: OrderContainer(
                                          status: ProductStatus.approved.name,
                                          receiverEmail:
                                              request.get("requester_email"),
                                          receiverPhone:
                                              request.get("requester_phone"),
                                          receiverImage:
                                               request['urlImage'][0],
                                          receiverName:
                                              request.get("requester_name"),
                                          uid: request.id,
                                          receiverID:
                                              request.get("requester_id"),
                                          text: request.get("title"),
                                          color1: AppColors.grey,
                                          color2: AppColors.blue,
                                          isFree: request.get("isFree"),
                                          address:
                                              request.get("requester_address"),
                                          price:
                                              "Price:\t\t\t${request.get("price")}",
                                          time:
                                              "time:\t\t\t\t${DateFormat("d-MMM-yyyy mm:ss a").format(request.get("request_time").toDate())}"),
                                    );
                                  }),
                            ],
                          );
                        }

                        return CustomLoader();
                      }),
                  Gap.h(80),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.h(10),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(REQUEST_COLLECTION)
                          .where("uid",
                              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                          .where("request",
                              isEqualTo: ProductStatus.rejected.name)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Center(
                                child: Text(
                                  "${snapshot.data.docs.length} Rejected Requests",
                                  //textAlign: TextAlign.center,
                                  style: AppTextStyles
                                      .textStyleNormalBody_BlueColor
                                      .copyWith(color: AppColors.red),
                                ),
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    var request = snapshot.data.docs[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: OrderContainer(
                                          status: ProductStatus.rejected.name,
                                          uid: request.id,
                                          text: request.get("title"),
                                          receiverImage:
                                               request['urlImage'][0],
                                          receiverEmail:
                                              request.get("requester_email"),
                                          receiverID:
                                              request.get("requester_id"),
                                          receiverPhone:
                                              request.get("requester_phone"),
                                          receiverName:
                                              request.get("requester_name"),
                                          color1: AppColors.grey,
                                          color2: AppColors.blue,
                                          isFree: request.get("isFree"),
                                          address:
                                              request.get("requester_address"),
                                          price:
                                              "Price:\t\t\t${request.get("price")}",
                                          time:
                                              "time:\t\t\t\t${DateFormat("d-MMM-yyyy mm:ss a").format(request.get("request_time").toDate())}"),
                                    );
                                  }),
                            ],
                          );
                        }

                        return CustomLoader();
                      }),
                  Gap.h(80),
                ],
              ),
            ),
          ])),
    );
  }
}
