import 'package:bellehouse/model/messages_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //get the instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //SEND MESSAGES
  Future<void> sendMessage(
      String receiverId, String message, String receiverName) async {
    //get the current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    AMessage newMessage = AMessage(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      timestamp: timestamp,
      message: message,
      name: receiverName,
    );
    //construct chat room id from current user id and receiver id (sorted to ensure uniqueness)
    List<String> ids = [receiverId, currentUserId];
    ids.sort(); //sort the ids (this ensures the chat room id is always the same for any pair of users)
    String chatRoomId = ids.join('_');
    //add new message to the database
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //GET MESSAGES
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //construct chat room id from user ids (sorted to ensure it matches the id used when sending mesages)

    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('TimeStamp', descending: true)
        .snapshots();
  }
}
