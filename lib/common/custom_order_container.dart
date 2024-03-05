// ignore_for_file: must_be_immutable

import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controller/provider/product/status.dart';
import '../utils/app_colors.dart';

class OrderContainer extends StatelessWidget {
  OrderContainer(
      {super.key,
      required this.uid,
      required this.text,
      required this.isFree,
      required this.color1,
      required this.color2,
      required this.time,
      required this.address,
      required this.price});
  var text, uid, color1, color2, time, price, isFree, address;

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
              offset: Offset(2, 2),
              blurRadius: 10,
              color: AppColors.App
            )
          ],
            border: Border.all(color: AppColors.Grey),
            borderRadius: BorderRadius.circular(7),
            color: AppColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  text,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
FirebaseFirestore.instance.collection(REQUEST_COLLECTION).doc(uid).update({"request": ProductStatus.rejected.name});
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
                  onTap: (){
                    FirebaseFirestore.instance.collection(REQUEST_COLLECTION).doc(uid).update({"request": ProductStatus.approved.name});
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
}
