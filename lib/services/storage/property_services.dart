import 'package:bellehouse/model/lands_class.dart';
import 'package:bellehouse/model/meuble_class.dart';
import 'package:bellehouse/model/houses_class.dart';
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
    bool diningroom,
    bool annexe,
    bool cuisine,
    bool meublee,
    String etatDeMaison,
    int view,
  ) async {
    //get user's infos

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
      view,
      annexe: annexe,
      cuisine: cuisine,
      diningroom: diningroom,
      meublee: meublee,
      etatDeMaison: etatDeMaison,
    );

    await _fireStore.collection('houses').add(newHouse.toMap());
  }

  //GET HOUSE
  Stream<QuerySnapshot> getHouse() {
    return _fireStore
        .collection('houses')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }

  //UPLOAD A NEW FURNITURE
  Future<void> uploadMeuble(
    String meubleImage,
    String meubleName,
    double price,
    String sellerName,
    String location,
    String description,
  ) async {
    //get user's infos

    final Timestamp timeStamp = Timestamp.now();
    //create a new meuble post
    final String id = _fireStore.collection('furnitures').doc().id;
    Furnitures newFurniture = Furnitures(
      description: description,
      timeStamp: timeStamp,
      meubleImage: meubleImage,
      meubleName: meubleName,
      sellerName: sellerName,
      location: location,
      price: price,
      meubleId: id,
    );

    await _fireStore.collection('furnitures').add(newFurniture.toMap());
  }

  //GET FURNITURES
  Stream<QuerySnapshot> getMeuble() {
    return _fireStore
        .collection('furnitures')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }

  //UPLOAD A NEW PARCELLE
  Future<void> uploadLand(
    String landImage,
    String location,
    double size,
    int views,
    double price,
    String type,
  ) async {
    final Timestamp timeStamp = Timestamp.now();

    Lands newLand = Lands(
      timeStamp: timeStamp,
      landImage: landImage,
      location: location,
      price: price,
      size: size,
      views: views,
      type: type,
    );
    await _fireStore.collection('lands').add(
          newLand.toMap(),
        );
  }
//GET LANDS

  Stream<QuerySnapshot> getLand() {
    return _fireStore
        .collection('lands')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
