import 'package:bhai_chara/chatt/live_chatt_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.black87,
          title: const Text(
            "Chats",
            style: TextStyle(color: Colors.white),
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('users', arrayContains: currentUserId)
            // .orderBy('lastUpdated', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final chats = snapshot.data!.docs;

          if (chats.isEmpty) {
            return const Center(child: Text("No chats found."));
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              final users = List<String>.from(chat['users']);
              final otherUserId =
                  users.firstWhere((uid) => uid != currentUserId);

              final lastMessage = chat['lastMessage'] ?? '';
              final timestamp = chat['lastUpdated'] as Timestamp?;

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Client')
                    .doc(otherUserId)
                    .get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return const SizedBox();
                  }

                  final userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;

                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.05), // 👈 light black / dark grey
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        userData['Name'] ?? 'Unknown',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        timestamp != null ? _formatTimestamp(timestamp) : '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              chatRoomId: chat.id,
                              otherUserId: otherUserId,
                              otherUserName: userData['Name'],
                              otherUserImage: userData['image'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }
}


// class ChattListScreen extends StatelessWidget {
//   const ChattListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor:AppColors.black,
          
//         title: const Text("Chats"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 12.0),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width ,
//                   height: 50,
//                   child: TextFormField(
//                       decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     hintText: "Type here",
//                     hintStyle: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w400),
//                   )),
//                 ),
//               ),
//               for (int i = 0; i <= 15; i++)
//                 InkWell(
//                   onTap: (){
//                     push(context,const LiveChattScreen());
//                   },
//                   child: ListTile(
//                     leading: const CircleAvatar(radius: 25),
//                     title: Text(
//                       "Kashaf Waheed",
//                       style: AppTextStyles.textStyleNormalBodyMedium,
//                     ),
//                     subtitle: Text(
//                       "hello",
//                       style: AppTextStyles.textStyleNormalBodyXSmall
//                           .copyWith(color: AppColors.grey),
//                     ),
//                     trailing: Text(
//                       "3/7/23",
//                       style: AppTextStyles.textStyleNormalBodyXSmall
//                           .copyWith(color: AppColors.grey),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
   
   
//     );
//   }
// }
