// ignore_for_file: file_names
import 'package:bellehouse/screen/otp_screen.dart';
import 'package:bellehouse/utilities/dialogs/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthProvider() {
    checkSignIn();
  }
  void checkSignIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _isSignedIn = sharedPreferences.getBool("is_signedIn") ?? false;
    notifyListeners;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
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
}
