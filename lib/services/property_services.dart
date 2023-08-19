import 'package:bellehouse/model/property_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PropertyService extends ChangeNotifier {
  //get the instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //UPLOAD A NEW HOUSE
  Future<void> uploadHouse(
    String postImage,
    String city,
    double rating,
    String type,
    String contractType,
    double price,
    String area,
    int bedrooms,
    int bathrooms,
    double size,
    String agentName,
    String agentPhoto,
    String agentEmail,
  ) async {
    //get user's infos
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String agentEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timeStamp = Timestamp.now();
//create a new house post

    Property newHouse = Property(
      postImage: postImage,
      city: city,
      rating: rating,
      type: type,
      contractType: contractType,
      price: price,
      area: area,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      size: size,
      agentName: agentName,
      agentPhoto: agentPhoto,
      timeStamp: timeStamp,
      agentEmail: agentEmail,
    );

    String propertyId = currentUserId;
    await _fireStore
        .collection('properties')
        .doc(propertyId)
        .collection('houses')
        .add(newHouse.toMap());
  }

  //GET HOUSE
  Stream<QuerySnapshot> getHouse(String userId) {
    return _fireStore
        .collection('properties')
        .doc(userId)
        .collection('houses')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }

  //UPLOAD A NEW FURNITURE

  //UPLOAD A NEW PARCELLE
}
