import 'dart:developer';

import 'package:bhai_chara/utils/container_with_img.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_loader.dart';
import '../../utils/push.dart';
import 'product_details_screen.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;
  String key = '';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      PopupMenuButton(itemBuilder: (context) {
        return [
          PopupMenuItem(
              onTap: () {
                key = 'title';
              },
              child: Text("Serch by title")),
          PopupMenuItem(
              onTap: () {
                key = 'category';
              },
              child: Text("Serch by category")),
          PopupMenuItem(
              onTap: () {
                key = 'subcategory';
              },
              child: Text("Serch by subcategory")),
          PopupMenuItem(
              onTap: () {
                key = 'price';
              },
              child: Text("Serch by price")),
          // PopupMenuItem(
          //     onTap: () {
          //       key = 'free';
          //     },
          //     child: Text("Serch by free")),
        ];
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () =>{
        key='',
         Navigator.of(context).pop()},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // final List<String> searchResults = searchList
    // .where((item) => item.toLowerCase().contains(query.toLowerCase()))
    // .toList();
    if (query.isNotEmpty) {
      switch (key) {
        case 'category':
          {
            
            stream = FirebaseFirestore.instance
                .collection("Products")
                .where(Filter.and(
                    Filter("uid",
                        isNotEqualTo: FirebaseAuth.instance.currentUser?.uid),
                    Filter('category', whereIn: [query])))
                .snapshots();
            break;
          }
        case 'subcategory':
          {
            stream = FirebaseFirestore.instance
                .collection("Products")
                .where(Filter.and(
                    Filter("uid",
                        isNotEqualTo: FirebaseAuth.instance.currentUser?.uid),
                    Filter('subcategory', whereIn: [query])))
                .snapshots();
            break;
          }
        case 'price':
          {
            stream = FirebaseFirestore.instance
                .collection("Products")
                .where(Filter.and(
                    Filter("uid",
                        isNotEqualTo: FirebaseAuth.instance.currentUser?.uid),
                    Filter('price', whereIn: [query])))
                .snapshots();
            break;
          }
        default:
          {
            stream = FirebaseFirestore.instance
                .collection("Products")
                .where(Filter.and(
                    Filter("uid",
                        isNotEqualTo: FirebaseAuth.instance.currentUser?.uid),
                    Filter('title', whereIn: [query])))
                .snapshots();
          }
      }
    }
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          QuerySnapshot data = snapshot.data;
          List<DocumentSnapshot> filteredData = [];

          for (int index = 0; index < data.docs.length; index++) {
            DocumentSnapshot dataDoc = data.docs[index];
            //   bool isFree =
            //       dataDoc.get('isFree');
            //   if (selected == "All" ||
            //       (selected == "Free" &&
            //           isFree) ||
            //       (selected == "Paid" &&
            //           !isFree)) {
            filteredData.add(dataDoc);
            //   }
          }

          return filteredData.isEmpty?Center(child: Text("No Data found"),): GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              DocumentSnapshot dataDoc = filteredData[index];

              return CustomContainerBox(
                isfree: dataDoc.get('isFree'),
                text: dataDoc.get('title'),
                secondText: dataDoc.get('description'),
                imgLink: NetworkImage(dataDoc.get('urlImage')[0]),
                ontap: () {
                  push(
                    context,
                    ProductScreen(
                      id: dataDoc.id,
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
    );

    // return ListView.builder(
    //   itemCount: searchResults.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       title: Text(searchResults[index]),
    //       onTap: () {
    //         // Handle the selected search result.
    //         close(context, searchResults[index]);
    //       },
    //     );
    //   },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      stream = FirebaseFirestore.instance
          .collection("Products")
          .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .snapshots();
    }
    // final List<String> suggestionList = query.isEmpty
    //     ? []
    //     : searchList
    //         .where((item) => item.toLowerCase().contains(query.toLowerCase()))
    //         .toList();
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          QuerySnapshot data = snapshot.data;
          List<DocumentSnapshot> filteredData = [];

          for (int index = 0; index < data.docs.length; index++) {
            DocumentSnapshot dataDoc = data.docs[index];
            //   bool isFree =
            //       dataDoc.get('isFree');
            //   if (selected == "All" ||
            //       (selected == "Free" &&
            //           isFree) ||
            //       (selected == "Paid" &&
            //           !isFree)) {
            filteredData.add(dataDoc);
            //   }
          }

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              DocumentSnapshot dataDoc = filteredData[index];

              return CustomContainerBox(
                isfree: dataDoc.get('isFree'),
                text: dataDoc.get('title'),
                secondText: dataDoc.get('description'),
                imgLink: NetworkImage(dataDoc.get('urlImage')[0]),
                ontap: () {
                  push(
                    context,
                    ProductScreen(
                      id: dataDoc.id,
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
    );
  }
}
