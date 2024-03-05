import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_colors.dart';
import 'text-styles.dart';

// ignore: must_be_immutable
class ItemContainer extends StatelessWidget {
  ItemContainer({
    super.key,
    required this.titleText,
    required this.title,
    required this.time,
    required this.imageLink,
    required this.category,
    required this.subcategory,
    this.ontap,
  });
  var imageLink, titleText, time,title, ontap, category = "", subcategory = "";
  @override
  Widget build(BuildContext context) {
    return InkWell(
                        onTap: ontap,

      child: Container(
        // height: 220,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
        color: AppColors.primary,
          boxShadow: [BoxShadow(
            blurRadius: 10,
            offset: Offset(2, 2),          
          color: AppColors.App
          )],
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border(
              left: BorderSide(color: AppColors.black),
              top: BorderSide(color: AppColors.black),
              right: BorderSide(color: AppColors.black),
              bottom: BorderSide(color: AppColors.black),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "From: ${DateFormat.yMd().add_jm().format(DateTime.parse(time))}",
              style: AppTextStyles.textStyleSubtitleSmallBody,
            ),
            Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  InkWell(
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        image: DecorationImage(
                            image: NetworkImage(imageLink), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ]),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.textStyleTitleBodySmall.copyWith(
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Rs:',
                              style: AppTextStyles.textStyleSubtitleSmallBody
                                  .copyWith(color: AppColors.grey),
                            ),
                            SizedBox(
                              width: 05,
                            ),
                            Text(
                              titleText,
                            
                              style: AppTextStyles.textStyleBoldBodyXSmall
                                  .copyWith(color: AppColors.blue),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "Category: ",
                            
                              style: AppTextStyles.textStyleBoldXLBodySmall.copyWith(
                                fontSize: 12
                              )),
                          TextSpan(
                              text: category,
                              style: AppTextStyles.textStyleNormalBodyXSmall.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ))
                        ])),
                       
                        Text.rich(
                        
                          TextSpan(children: [
                          TextSpan(
                              text: "Sub Category: ",
                              style: AppTextStyles.textStyleBoldXLBodySmall.copyWith(
                                fontSize: 12
                              )),
                          TextSpan(
                          
                              text: subcategory,
                              style: AppTextStyles.textStyleNormalBodyXSmall.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),)
                        ])),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 20,
            // ),
    
            // // rowww
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text.rich(TextSpan(children: [
            //       TextSpan(
            //           text: "Views: ",
            //           style: AppTextStyles.textStyleBoldXLBodySmall.copyWith(
            //                     fontSize: 12
            //                   )),
            //       TextSpan(
            //           text: "0", style: AppTextStyles.textStyleSubtitleSmallBody),
            //     ])),
            //     Container(
            //       height: 25,
            //       width: 2,
            //       color: AppColors.black,
            //     ),
            //     Text.rich(TextSpan(children: [
            //       TextSpan(
            //           text: "Tel: ",
            //           style: AppTextStyles.textStyleBoldXLBodySmall.copyWith(
            //                     fontSize: 12
            //                   )),
            //       TextSpan(
            //           text: "0", style: AppTextStyles.textStyleSubtitleSmallBody),
            //     ])),
            //     Container(
            //       height: 25,
            //       width: 2,
            //       color: AppColors.black,
            //     ),
            //     Text.rich(TextSpan(children: [
            //       TextSpan(
            //           text: "Likes: ",
            //           style: AppTextStyles.textStyleBoldXLBodySmall.copyWith(
            //                     fontSize: 12
            //                   )),
            //       TextSpan(
            //           text: "0", style: AppTextStyles.textStyleSubtitleSmallBody),
            //     ])),
            //     Container(
            //       height: 25,
            //       width: 2,
            //       color: AppColors.black,
            //     ),
            //     Text.rich(TextSpan(children: [
            //       TextSpan(
            //           text: "Chat: ",
            //           style: AppTextStyles.textStyleBoldXLBodySmall.copyWith(
            //                     fontSize: 12
            //                   )),
            //       TextSpan(
            //           text: "0", style: AppTextStyles.textStyleSubtitleSmallBody),
            //     ])),
            //   ],
            // ),
          
          ],
        ),
      ),
    );
  }
}
