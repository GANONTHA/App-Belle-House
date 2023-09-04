// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:bellehouse/model/user_model.dart';
import 'package:bellehouse/screen/otp_screen.dart';
import 'package:bellehouse/utilities/dialogs/util_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool _isLoading = false;
  String? _uid;
  bool get isSignedIn => _isSignedIn;
  bool get isLoading => _isLoading;
  String? get uid => _uid;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSignIn();
  }
  void checkSignIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _isSignedIn = sharedPreferences.getBool("is_signedIn") ?? false;
    notifyListeners;
  }

  Future setSignIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool("is_signedIn", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          //pinController.setText(phoneAuthCredential.smsCode!);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: ((verificationId, forceResendingToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                verificationId: verificationId,
              ),
            ),
          );
        }),
        codeAutoRetrievalTimeout: ((verificationId) {}),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

//verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user!;
      _uid = user.uid;
      onSuccess();
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

//DATABASE OPERATION
  //checking if user exists
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _fireStore.collection('users').doc(uid).get();

    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  //create user
  void createUser({
    required BuildContext context,
    required UserModel userModel,
    required File profilePicture,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      //upload the image to firebase storage
      await storeToStorage("profilePicture/$_uid", profilePicture)
          .then((value) {
        userModel.profilePicture = value;
        userModel.createAt = DateTime.now().millisecondsSinceEpoch.toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.uid;
      });
      _userModel = userModel;
//uploading to database
      await _fireStore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      notifyListeners();
    }
  }

  Future<String> storeToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

//get user infos from firestore
  Future getDataFromFireStore() async {
    await _fireStore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        email: snapshot['email'],
        name: snapshot['name'],
        bio: snapshot['bio'],
        profilePicture: snapshot['profilePicture'],
        createAt: snapshot['createAt'],
        phoneNumber: snapshot['phoneNumber'],
        uid: snapshot['uid'],
      );
      _uid = userModel!.uid;
    });
  }

  //storing data locally
  Future saveUserDataSharePreference() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        "user_model", jsonEncode(userModel?.toMap()));
  }

  Future getDataFromSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String data = sharedPreferences.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  //user signOut
  Future userSignOut() async {
    //remove from localstorage and firestore
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    sharedPreferences.clear();
  }
}
