import 'package:bhai_chara/utils/app_config.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/custom_order_container.dart';
import '../controller/services/Firebase_Manager.dart';
import '../utils/app_colors.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.white,
          title: Text(
                "Requests",
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.h(10),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection(REQUEST_COLLECTION)
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Center(
                            child: Text(
                              "${snapshot.data.docs.length} New Requests",
                              //textAlign: TextAlign.center,
                              style: AppTextStyles
                                  .textStyleNormalBody_BlueColor,
                            ),
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                var request = snapshot.data.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,),
                                  child: OrderContainer(
                                      text: request.get("title"),
                                      color1: AppColors.grey,
                                      color2: AppColors.blue,
                                      isFree: request.get("isFree"),
                                      address: request.get("requester_address"),
                                      price: "Price:\t\t\t${request.get("price")}",
                                      time:
                                          "time:\t\t\t\t${DateFormat("d-MMM-yyyy mm:ss a").format(request.get("request_time").toDate())}"),
                                );
                              }),
                              
                        ],
                      );
                    }
          
                    return CustomLoader();
                    
                  }
                  ),
                   Gap.h(80),
            ],
          ),
        ));
  }
}
