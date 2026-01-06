import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomContainerBox extends StatelessWidget {
  var text, secondText, imgLink, ontap, isfree;
  CustomContainerBox(
      {super.key,
      required this.text,
      this.imgLink,
      required this.secondText,
      required this.ontap,
      required this.isfree});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size;
    print(imgLink);
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
        height: 300,
        //  width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: imgLink ??
                      'https://www.google.com/imgres?q=cat&imgurl=https%3A%2F%2Fi.natgeofe.com%2Fn%2F548467d8-c5f1-4551-9f58-6817a8d2c45e%2FNationalGeographic_2572187_16x9.jpg%3Fw%3D1200&imgrefurl=https%3A%2F%2Fwww.nationalgeographic.com%2Fanimals%2Fmammals%2Ffacts%2Fdomestic-cat&docid=K6Qd9XWnQFQCoM&tbnid=VCezPSgAAsDM2M&vet=12ahUKEwjE5t3nktiOAxUI6wIHHb-RHnoQM3oECAwQAA..i&w=1200&h=675&hcb=2&ved=2ahUKEwjE5t3nktiOAxUI6wIHHb-RHnoQM3oECAwQAA',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image, size: 40),
                ),
              ),
              // Container(
              //   height: 120,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: imgLink,
              //       fit: BoxFit.cover,
              //     ),
              //     borderRadius: const BorderRadius.only(
              //         topRight: Radius.circular(10),
              //         topLeft: Radius.circular(10)),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 5),
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: AppTextStyles.textStyleBoldBodySmall,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      Text(
                        secondText,
                        style: AppTextStyles.textStyleBoldBodyXSmall,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      Text(
                        isfree ? "Free" : "Paid",
                        style: isfree
                            ? AppTextStyles.textStyleBoldBodyXSmall
                                .copyWith(color: AppColors.Green)
                            : AppTextStyles.textStyleBoldBodyXSmall
                                .copyWith(color: AppColors.yellow),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
