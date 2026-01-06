// ignore_for_file: must_be_immutable

import 'package:bhai_chara/chatt/chat_list_screen.dart';
import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:bhai_chara/utils/text-styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controller/provider/product/status.dart';
import '../main.dart';
import '../utils/app_colors.dart';


class OrderContainer extends StatefulWidget {
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
  State<OrderContainer> createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: const [
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
                  backgroundImage: NetworkImage(widget.receiverImage),
                  //  backgroundImage: AssetImage(receiverImage),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.receiverName,
                  // text,
                  style: AppTextStyles.textStyleBoldBodySmall,
                ),
              ],
            ),
            if (!widget.isFree)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  widget.price,
                  style: AppTextStyles.textStyleBoldBodyXSmall,
                  textAlign: TextAlign.start,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                widget.time,
                style: AppTextStyles.textStyleBoldBodyXSmall,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children:  [
                 const Icon(Icons.location_on),
                const  SizedBox(
                    width: 8,
                  ),
                  Text(widget.address ?? ""),
                ],
              ),
            ),
            if (widget.status == ProductStatus.pending.name)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection(REQUEST_COLLECTION)
                          .doc(widget.uid)
                          .update({"request": ProductStatus.rejected.name});
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: widget.color1),
                      child: Center(
                        child: Text(
                          "Decline",
                          // textAlign: TextAlign.center,
                          style: AppTextStyles.textStyleNormalBodySmall
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  InkWell(
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection(REQUEST_COLLECTION)
                          .doc(widget.uid)
                          .update({"request": ProductStatus.approved.name});
                      // if(!mounted) return;    
                      // startChat(context);
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: widget.color2),
                      child: Center(
                        child: Text(
                          "Accept",
                          // textAlign: TextAlign.center,
                          style: AppTextStyles.textStyleNormalBodySmall
                              .copyWith(color: AppColors.white),
                        ),
                      ),
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
    bool chatCreated = await requestProduct();
    if (chatCreated) {
      print('chat created successfully');
          navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => const ChatListScreen()),
    );
    } else {
      showSnack(context: context, text: "failed to Sent Message !");
    }

    // final ChatService chatService = ChatService();

    // await chatService.sendMessage(
    //   // receiverImage: receiverImage,
    //     recevierId: receiverID,
    //     message: "Are you Interested?",
    //     receiverEmail: receiverEmail,
    //     receiverName: receiverName);
  }

  Future<bool> requestProduct() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    String receiverUserId = widget.receiverID;

    List<String> ids = [currentUserId, receiverUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    print('chatroomId : $chatRoomId ');
    try {
      await FirebaseFirestore.instance.collection('chats').doc(chatRoomId).set({
        'users': [currentUserId, receiverUserId],
        'lastMessage': "Hello! I'm requesting this product",
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages')
          .add({
        'senderId': currentUserId,
        'receiverId': receiverUserId,
        'text': "Hello! I'm requesting this product",
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("Chat room and default message created!");
      return true;
    } catch (e) {
      print("🔥 Chat creation error: $e");
      return false;
    }
  }
}
