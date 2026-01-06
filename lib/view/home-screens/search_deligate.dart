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
              child: const Text("Serch by title")),
          PopupMenuItem(
              onTap: () {
                key = 'category';
              },
              child: const Text("Serch by category")),
          PopupMenuItem(
              onTap: () {
                key = 'subcategory';
              },
              child: const Text("Serch by subcategory")),
          PopupMenuItem(
              onTap: () {
                key = 'price';
              },
              child: const Text("Serch by price")),
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
      onPressed: () => {key = '', Navigator.of(context).pop()},
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

          return filteredData.isEmpty
              ? const Center(
                  child: Text("No Data found"),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot dataDoc = filteredData[index];

                      return CustomContainerBox(
                        isfree: dataDoc.get('isFree'),
                        text: dataDoc.get('title'),
                        secondText: dataDoc.get('description'),
                        imgLink: dataDoc.get('urlImage')[0],
                        ontap: () {
                          push(
                            context,
                            ProductScreen(
                              where: 'no',
                              id: dataDoc.id,
                            ),
                          );
                        },
                      );
                    },

                    // ignore: prefer_const_constructors
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: .85),
                  ),
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

          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                DocumentSnapshot dataDoc = filteredData[index];

                return CustomContainerBox(
                  isfree: dataDoc.get('isFree'),
                  text: dataDoc.get('title'),
                  secondText: dataDoc.get('description'),
                  imgLink: dataDoc.get('urlImage')[0],
                  ontap: () {
                    push(
                      context,
                      ProductScreen(
                        where: 'no',
                        id: dataDoc.id,
                      ),
                    );
                  },
                );
              },

              // ignore: prefer_const_constructors
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .85),
            ),
          );
        } else {
          return const Center(child: CustomLoader());
        }
      },
    );
  }
}
