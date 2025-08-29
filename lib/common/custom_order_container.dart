// ignore_for_file: must_be_immutable

import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controller/provider/product/status.dart';
import '../utils/app_colors.dart';
import '../view/chatting/controller/service/chatt_service.dart';

class OrderContainer extends StatelessWidget {
  OrderContainer(
      {super.key,
      required this.status,
      required this.uid,
      required this.receiverID,
      required this.receiverName,
      required this.receiverEmail,
      required this.receiverPhone,
      required this.text,
      required this.isFree,
      required this.color1,
      required this.color2,
      required this.time,
      required this.receiverImage,
      required this.address,
      required this.price});
  var text,
      uid,
      color1,
      color2,
      time,
      price,
      isFree,
      address,
      receiverName,
      receiverID,
      receiverEmail,
      receiverPhone,
      receiverImage,
      status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2), blurRadius: 10, color: AppColors.App)
            ],
            border: Border.all(color: AppColors.Grey),
            borderRadius: BorderRadius.circular(7),
            color: AppColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(receiverImage),
                  //  backgroundImage: AssetImage(receiverImage),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  receiverName,
                  // text,
                  style: AppTextStyles.textStyleBoldBodySmall,
                ),
              ],
            ),
            if (!isFree)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  price,
                  style: AppTextStyles.textStyleBoldBodyXSmall,
                  textAlign: TextAlign.start,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                time,
                style: AppTextStyles.textStyleBoldBodyXSmall,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 8,
                  ),
                  Text(address ?? ""),
                ],
              ),
            ),
            if(status == ProductStatus.pending.name)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection(REQUEST_COLLECTION)
                        .doc(uid)
                        .update({"request": ProductStatus.rejected.name});
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    child: Center(
                      child: Text(
                        "Decline",
                        // textAlign: TextAlign.center,
                        style: AppTextStyles.textStyleNormalBodySmall
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7), color: color1),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                InkWell(
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection(REQUEST_COLLECTION)
                        .doc(uid)
                        .update({"request": ProductStatus.approved.name});
                    // startChat(context);
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    child: Center(
                      child: Text(
                        "Accept",
                        // textAlign: TextAlign.center,
                        style: AppTextStyles.textStyleNormalBodySmall
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7), color: color2),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  startChat(context) async {
    final ChatService chatService = ChatService();

    await chatService.sendMessage(
      // receiverImage: receiverImage,
        recevierId: receiverID,
        message: "Are you Interested?",
        receiverEmail: receiverEmail,
        receiverName: receiverName);

    showSnack(context: context, text: "Message Sent!");
  }
}
