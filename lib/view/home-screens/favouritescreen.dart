import 'package:bhai_chara/view/home-screens/product_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/container_with_img.dart';
import '../../utils/custom_loader.dart';
import '../../utils/push.dart';

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
        title: const Text('Favourites', style: TextStyle(color: Colors.black),),
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
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
            if (snapshot.connectionState == ConnectionState.waiting) return const  CircularProgressIndicator(color: Colors.black,);      
            if (snapshot.hasData) {
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
                    imgLink:
                    //  const NetworkImage(
                    //     'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FTabby_cat&psig=AOvVaw1YiqXt27WoS7g14SbAIxzF&ust=1753537620333000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCMjLlf2X2I4DFQAAAAAdAAAAABAE'),
      
                    NetworkImage(
                        docData.get('urlImage')[0] != null ?   docData.get('urlImage')[0]  : 'https://www.google.com/imgres?q=cat&imgurl=https%3A%2F%2Fi.natgeofe.com%2Fn%2F548467d8-c5f1-4551-9f58-6817a8d2c45e%2FNationalGeographic_2572187_16x9.jpg%3Fw%3D1200&imgrefurl=https%3A%2F%2Fwww.nationalgeographic.com%2Fanimals%2Fmammals%2Ffacts%2Fdomestic-cat&docid=K6Qd9XWnQFQCoM&tbnid=VCezPSgAAsDM2M&vet=12ahUKEwjE5t3nktiOAxUI6wIHHb-RHnoQM3oECAwQAA..i&w=1200&h=675&hcb=2&ved=2ahUKEwjE5t3nktiOAxUI6wIHHb-RHnoQM3oECAwQAA' ),
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
            } else {
              return const Center(child: CustomLoader());
            }
          },
        ),
      ),
    );
  }
}
