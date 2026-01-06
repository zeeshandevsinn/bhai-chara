import 'package:bhai_chara/view/home-screens/product_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../chatt/chat_list_screen.dart';
import '../../utils/container_with_img.dart';
import '../../utils/custom_loader.dart';
import '../../utils/push.dart';
import 'package:bhai_chara/utils/app_colors.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    print('user id: ${FirebaseAuth.instance.currentUser?.uid}');
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Text(
              'Favourites',
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
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("favourites")
              .where("favouritedBy",
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomLoader());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No favourites added'));
            }
            QuerySnapshot data = snapshot.data;
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                final docData = data.docs[index];
                return CustomContainerBox(
                  isfree: docData['isFree'],
                  text: docData['title'],
                  secondText: docData['title'],
                  imgLink: docData.get('urlImage')[0],
                  ontap: () {
                    push(
                      context,
                      ProductScreen(
                        where: 'no',
                        userid: docData['uid'],
                        id: docData.id,
                      ),
                    );
                  },
                );
              },

              // ignore: prefer_const_constructors
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .85),
            );
          },
        ),
      ),
    );
  }
}
