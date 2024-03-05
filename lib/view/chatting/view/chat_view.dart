import 'package:bhai_chara/controller/services/Firebase_Manager.dart';

import '../../../../utils/app_colors.dart';
import 'package:bhai_chara/utils/push.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ConversationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bhai_chara/utils/text-styles.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  FocusNode searchFN = FocusNode();
  TextEditingController searchController = TextEditingController();
  PageController pageMove = PageController();
  int chatTypePageIndex = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.white,
        title: Text(
          "Chat",
          style: AppTextStyles.textStyleBoldBodyMedium,
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(onPressed: (){
        //     FirebaseAuth.instance.signOut();
        //   }, icon: Icon(Icons.star)),
        // ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(CHAT_COLLECTION)
              .where(Filter.or(
                Filter("senderId", isEqualTo: auth.currentUser?.uid),
                Filter("receverId", isEqualTo: auth.currentUser?.uid),
              ))
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                  children: snapshot.data!.docs
                      .map((docs) => buildUserListItems(docs))
                      .toList());
            }

            return const Text("Loading . . .");
          }),
    );
    // }

    // );
  }

  Widget buildUserListItems(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    // if (auth.currentUser!.email != data['senderEmail']) {
    var myID = FirebaseAuth.instance.currentUser?.uid;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
      child: Column(
        children: [
          ListTile(
            subtitle: Text(data['message'],
                style: AppTextStyles.textStyleNormalBodyXSmall),
            leading: const CircleAvatar(radius: 35),
            title: Text(
                data['senderId'] != myID
                    ? data["senderName"]
                    : data["recevierName"].toString(),
                style: AppTextStyles.textStyleNormalBodySmall),
            //  subtitle:  Text(' ',style:AppTextStyles.textStyleNormalBodyXSmall),
            onTap: () {
              push(
                  context,
                  ConversationScreen(
                    receiverImage: data['senderId'] != myID
                          ? data["senderImage"]
                          : data["receiverImage"],
                      
                      reciverUserID: data['senderId'] != myID
                          ? data["senderId"]
                          : data["receverId"],
                      reciverUserEmail: data['senderId'] != myID
                          ? data["senderEmail"]
                          : data["recevierEmail"],
                      receiverName: data['senderId'] != myID
                          ? data["senderName"]
                          : data["recevierName"]));
            },
          ),
        ],
      ),
    );
    // } else {
    //   return Container();
    // }
  }

//   Widget searchField() {
//     return TextFormField(
//       focusNode: searchFN,
//       controller: searchController,
//       keyboardType: TextInputType.text,
//       textInputAction: TextInputAction.done,
//       onChanged: (value) {
//         debugPrint('Search');
//         setState(() {});
//       },
//       onTap: () {
//         setState(() {});
//       },
//       onFieldSubmitted: (value) {
//         setState(() {});
//       },
//       // validator: FieldValidator.validateEmail,
//       // autovalidateMode: AutovalidateMode.onUserInteraction,
//       decoration: InputDecoration(
//          border: OutlineInputBorder(),
//         hintText: "Search",
//         icon: Icon(
//           Icons.search,
//           color: searchFN.hasFocus ? Colors.green : Colors.grey,
//         ),
//       ),
//     );
//   }
}
