import 'package:cloud_firestore/cloud_firestore.dart';

class AMessage {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final Timestamp timestamp;
  final String message;

  AMessage({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.timestamp,
    required this.message,
  });

  //convert to Map (because infos are stored in Firebase in Map format)

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'TimeStamp': timestamp,
      'message': message
    };
  }
}
