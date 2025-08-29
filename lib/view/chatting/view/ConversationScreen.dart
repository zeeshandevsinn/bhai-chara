import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../utils/app_colors.dart';
import 'package:bhai_chara/utils/text-styles.dart';

import '../../../controller/services/shared_prefrences.dart';
import '../controller/service/chatt_service.dart';
import 'widget/chat_bubble.dart';

class ConversationScreen extends StatefulWidget {
  ConversationScreen(
      {super.key,
      required this.reciverUserID,
      // required this.receiverImage,
      required this.reciverUserEmail,
      required this.receiverName});
  final String reciverUserID;
  // final String receiverImage;
  final String receiverName;
  final String reciverUserEmail;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
  sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
        // receiverImage:widget.receiverImage,
          recevierId: widget.reciverUserID,
          message: messageController.text,
          receiverEmail: widget.reciverUserEmail,
          receiverName: widget.receiverName);
      messageController.clear();
    }
  }

  Widget buildMessageInput() {
    return
        //  Center(
        //           child: Padding(
        //             padding: const EdgeInsets.only(bottom: 0),
        //             child: Container(
        //                 decoration: const BoxDecoration(
        //                   color: Colors.white,
        //                   borderRadius: BorderRadius.all(Radius.circular(5)),
        //                 ),
        //                 height: 60,
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: 10),
        //                       child: Row(
        //                         children: [
        //                           // const Icon(Icons.add, size: 33,),
        //                           Expanded(
        //                               child: Column(
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             children: [
        //                               Container(
        //                                 height: 40,
        //                                 decoration: BoxDecoration(
        //                                     color: const Color.fromARGB(255, 232, 230, 230),
        //                                     borderRadius: BorderRadius.circular(20)),
        //                                 child: Padding(
        //                                   padding: const EdgeInsets.symmetric(
        //                                       horizontal: 20),
        //                                   child: TextFormField(
        //                                     controller: messageController,
        //                                     decoration: const InputDecoration(
        //                                         hintText: " Write a message",
        //                                         hintStyle: TextStyle(fontSize: 14),
        //                                         border: InputBorder.none),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ],
        //                           )),
        //                           InkWell(
        //                             onTap: () {
        //                               sendMessage;
        //                             },
        //                             child: Padding(
        //                               padding: const EdgeInsets.symmetric(horizontal: 8),
        //                               child: Container(
        //                                 height: 40,
        //                                 width: 42,
        //                                 decoration: BoxDecoration(
        //                                     color: AppColors.black,
        //                                     borderRadius: BorderRadius.circular(40)),
        //                                 child: const Center(child: Icon(Icons.send,color: Colors.white,size: 22,))
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 )),
        //           ),
        //         );
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 230, 230),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  
                  scrollPadding: EdgeInsets.zero,
                  controller: messageController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    isDense: false,
                    contentPadding: EdgeInsets.only(bottom: 10),
                      hintText: " Write a message",
                      hintStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
              radius: 20,
              child: Center(
                  child: IconButton(
                      onPressed: sendMessage, icon: Icon(Icons.send)))),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
        stream: chatService.getMessage(
          widget.reciverUserID,
          firebaseAuth.currentUser!.uid,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erorr${snapshot.error}');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          } else {
            return ListView(
              children: snapshot.data!.docs
                  .map<Widget>((document) => buildMessageItem(document))
                  .toList(),
            );
          }
        });
  }

  Widget buildMessageItem(var document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alinment = (data['senderId'] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
        alignment: alinment,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment:
                (data['senderId'] == firebaseAuth.currentUser!.uid)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            mainAxisAlignment:
                (data['senderId'] == firebaseAuth.currentUser!.uid)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    (data['senderId'] == firebaseAuth.currentUser!.uid)
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                mainAxisAlignment:
                    (data['senderId'] == firebaseAuth.currentUser!.uid)
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [
                  data['senderId'] == firebaseAuth.currentUser!.uid
                      ? Text(" ")
                      : CircleAvatar(radius: 15, backgroundImage: NetworkImage(
                        data['senderId'] == firebaseAuth.currentUser!.uid ? data["senderImage"] :
                        data["receiverImage"]),),
                  SizedBox(width: 8),
                  Text(data['senderEmail']),
                ],
              ),
              const SizedBox(height: 5),
              ChatBubble(
                text: DateFormat('dd/MMM/yyyy, hh:mm a')
                    .format(data['timestamp'].toDate()),
                // alignment: alinment,

                message: data['message'],
                leftpadding:
                    data['senderId'] == firebaseAuth.currentUser!.uid ? 60 : 40,
                rightpadding:
                    data['senderId'] == firebaseAuth.currentUser!.uid ? 0 : 40,
                fontcolor: data['senderId'] == firebaseAuth.currentUser!.uid
                    ? AppColors.white
                    : AppColors.black,
                color: data['senderId'] == firebaseAuth.currentUser!.uid
                    ? const Color.fromARGB(255, 5, 101, 179)
                    : AppColors.skyblue,
              ),
              // Align(
              //     alignment: data['senderId'] == firebaseAuth.currentUser!.uid
              //         ? Alignment.bottomRight
              //         : Alignment.bottomLeft,
              //     child: Padding(
              //       padding: const EdgeInsets.only(left:50.0,top:8),
              //       child: Text(
              //           DateFormat('dd/MMM/yyyy, hh:mm a')
              //               .format(data['timestamp'].toDate()),
              //           style: AppTextStyles.textStyleNormalBodyXSmall.copyWith(
              //               color: AppColors.black,
              //               fontSize: 10)),
              //     )),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          leadingWidth: 85,
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          title: Text(widget.receiverName,
              style: AppTextStyles.textStyleBoldBodyMedium
                  .copyWith(color: AppColors.black)),
          leading: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              CircleAvatar(radius: 18),
            ],
          )),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Expanded(
                child: buildMessageList(),
              ),
              const SizedBox(
                height: 10,
              ),
              buildMessageInput(),
              const SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }
}
