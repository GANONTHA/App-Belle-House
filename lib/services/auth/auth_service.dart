import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  //instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//instance of firestore

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //SIGN USER IN
  Future<UserCredential> signIn(
    String email,
    String password,
  ) async {
    try {
      //sign in
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //add a new document for the user in user collection if doesn't already existe
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));
      return userCredential;
      //catch any error
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
//CREATE A USER

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password, String name, String phone) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
//after creating a user, create a document for the user in the users collection
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'phoneNumber': phone
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //SIGN USER OUT
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
