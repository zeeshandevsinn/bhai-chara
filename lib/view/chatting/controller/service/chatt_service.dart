import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../controller/services/shared_prefrences.dart';
import '../../../../model/user_model.dart';
import '../../model/message.dart';



class ChatService extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

final SharedPreferenceHelper _sharedPrefHelper =
      SharedPreferenceHelper.instance();
  Future<void> sendMessage({
    // required receiverImage, 
    required recevierId,required message,required  receiverEmail,required receiverName })async{

      UserModel? user =   await _sharedPrefHelper.user();
  DateTime now = new DateTime.now();
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String curentUserEmail = firebaseAuth.currentUser!.email.toString();

    final Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
      // receiverImage: receiverImage,
      // senderImage: user!.image!,
      senderId: currentUserId,
      senderEmail: curentUserEmail,
      senderName: user!.name!,
      receverId: recevierId,
      recevierEmail: receiverEmail,
      recevierName: receiverName,
      timestamp: timestamp,
      message: message,
    );

    List<String> ids = [currentUserId,recevierId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await firestore.collection(CHAT_COLLECTION).doc(chatRoomId).set(newMessage.toMap());
    await firestore.collection(CHAT_COLLECTION).doc(chatRoomId).collection('messages').add(newMessage.toMap());
      }


    Stream<QuerySnapshot> getMessage(String userId,String otherUserId){
       List<String> ids = [userId,otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    print(chatRoomId);
    return firestore.collection(CHAT_COLLECTION).doc(chatRoomId).collection('messages').orderBy('timestamp',descending:false).snapshots();
      
    }
}