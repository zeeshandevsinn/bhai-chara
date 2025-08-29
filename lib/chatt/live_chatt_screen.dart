import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserImage;

  const ChatScreen({
    super.key,
    required this.chatRoomId,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatRoomId)
        .collection('messages')
        .add({
      'senderId': currentUserId,
      'receiverId': widget.otherUserId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update last message in chat document
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatRoomId)
        .set({
      'lastMessage': text,
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.otherUserName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.chatRoomId)
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg['senderId'] == currentUserId;

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Colors.blueAccent.withOpacity(0.8)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          msg['text'],
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: "Type a message..."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



// import 'package:bhai_chara/utils/app_colors.dart';
// import 'package:bhai_chara/utils/text-styles.dart';
// import 'package:flutter/material.dart';

// import '../common/custom_messagefield.dart';

// class LiveChattScreen extends StatelessWidget {
//   const LiveChattScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.black,
//         foregroundColor: AppColors.white,
//         leading:IconButton(onPressed: (){
//           Navigator.pop(context);
//         }, icon: const Icon(Icons.arrow_back_ios)),
//         elevation: 0,
//        leadingWidth: 20,
//         actions: const [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Icon(Icons.phone),
//           ),
//         ],
//         title: Row(
//           children: [
//            const  CircleAvatar(
//               radius: 20,
//             ),
//            const  SizedBox(
//               width: 15,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Kashaf",
//                     style: AppTextStyles.textStyleNormalBodySmall
//                         .copyWith(color: AppColors.white)),
//                 Text("online",
//                     style: AppTextStyles.textStyleNormalBodyXSmall
//                         .copyWith(color: AppColors.white)),
//               ],
//             )
//           ],
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(colors: [AppColors.skyblue, Colors.white,],begin: Alignment.bottomLeft),),
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   BuildTextMesg("Hi, how are you doing today"),
//                   BuildTextMesg("I'm good too, what's up?"),
//                   BuildReceiveMesg("Nothing speciall"),
//                   BuildReceiveMesg("What's going on?"),
//                   BuildTextMesg("Working "),
//                   BuildReceiveMesg("That's good"),
//                   BuildReceiveMesg("That's good\n asdfghjklswedrtyuiozxcvbnhat's good asdfgh\njklswedrtyuiozxcvbnm,werftowerha\nt's at's good asdfghjklswedrty\nuiozxcvbnhat's good asdfghjklswed\nrtyuiozxcvbnm,werftowerhat's good a\nsdfghjklswedrtyuiozxcvbnm,werftowerhat's good asdfghj\nklswedrtyuiozxcvbn\nm,werftowerhat's good asdfghjklswedrtyuiozxcvbnm,we\nrftowerm,werftowertyuiohat's good asdfghjklswedrty\nuihat's good asdfghjklswedrtyuiozxcvbnm,werftowerogood a\nsdfghjklswedrtyuiozxcvbnm,werftowerhat's g\nood asdfghjklswedrtyuiozxcvbnm,werftowerhat's good asdfghjklswed\nrtyuiozxcvbnm,werftowerm,werftowertyui\nohat's good asdfghjklswedrtyuihat's good asdfghjklswedrtyuiozxcvbnm,werftowerozxcvbnm,werftower"),
//                   BuildTextMesg("That's good asdfghjklswedat's good asdfghjklswedrtyuiozxcvbnhat's good asdfghjklswedrtyuiozxcvbnm,werftowerhat's good asdfghjklswedrtyuiozxcvbnm,werftowerhat's good asdfghjklswedrtyuiozxcvbnm,werftowerhat's good asdfghjklswedrtyuiozxcvbnm,werftowerm,werftowertyuiohat's good asdfghjklswedrtyuihat's good asdfghjklswedrtyuiozxcvbnm,werftowerortyuiozxcvbnhat's good asdfghjklswedrtyuiozxcvbnm,werftowerhat's good asdfghjklswedrtyuiozxcvbnm,werftowerhat's good asdfghjklswedrtyuiozxcvbnm,werftowerhat's good asdfghjklswedrtyuiozxcvbnm,werftowerm,werftowertyuiohat's good asdfghjklswedrtyuihat's good asdfghjklswedrtyuiozxcvbnm,werftowerozxcvbnm,werftower"),
//         const  SizedBox(height: 50,)
                  
//                 ],
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Row(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width - 55,
//                   child: Container(
//                     margin:const  EdgeInsets.symmetric(
//                       horizontal: 2,
//                     ),
//                     decoration: BoxDecoration(
//                         color: AppColors.white,
//                         borderRadius: BorderRadius.circular(25)),
//                     child: TextFormField(
//                       textAlignVertical: TextAlignVertical.center,
//                       keyboardType: TextInputType.multiline,
//                       maxLines: 5,
//                       minLines: 1,
//                       decoration: InputDecoration(
//                         hintText: "Type a message",
//                         border: InputBorder.none,
//                         contentPadding: const EdgeInsets.all(5),
//                         prefixIcon: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.attach_file),
//                         ),
                      
//                         suffixIcon: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.camera_alt),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
//                   child: CircleAvatar(
//                     radius: 25,
//                     child: IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.mic,
//                         color: AppColors.white,
//                       ),
//                       color: AppColors.blue,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
