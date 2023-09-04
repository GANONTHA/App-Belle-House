import 'package:bellehouse/services/auth/authProvider.dart';
import 'package:bellehouse/utilities/Authentification/user_info_screen.dart';
import 'package:bellehouse/utilities/util_functions.dart';
import 'package:bellehouse/utilities/home_page.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  const OTPScreen({super.key, required this.verificationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? optCode;
  @override
  Widget build(BuildContext context) {
    final _isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
          color: const Color.fromARGB(212, 235, 244, 244),
        ),
      ),
      backgroundColor: const Color(0xFF6C63FF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: _isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Color(0xFF6C63FF),
                ))
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(212, 235, 244, 244),
                          ),
                          child: Image.asset(
                            "lib/assets/logo.png",
                            color: const Color(0xFF6C63FF),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      const Text(
                        'Verification',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(212, 235, 244, 244)),
                      ),
                      const SizedBox(height: 15.0),
                      const Text(
                        "Entrer le code OTP qui a été envoyé sur votre numero de telephone",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(212, 235, 244, 244),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Pinput(
                        // androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                        // controller: pinController,
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(212, 235, 244, 244),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              color: const Color.fromARGB(212, 235, 244, 244),
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            optCode = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(212, 235, 244, 244),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: TextButton(
                          child: const Text(
                            'Verifier',
                            style: TextStyle(
                              color: Color(0xFF6C63FF),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.4,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
                            if (optCode != null) {
                              verifyOtp(context, optCode!);
                            } else {
                              showSnackBar(
                                  context, "Entrer le code a 6 chiffres");
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        "Vous n'aviez pas recu le code ?",
                        style: TextStyle(
                          color: Color.fromARGB(212, 235, 244, 244),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        "Renvoyer le code",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  //verify opt
  void verifyOtp(BuildContext context, String userOTP) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOTP: userOTP,
      onSuccess: () {
        ap.checkExistingUser().then((value) {
          if (value == true) {
            ap.getDataFromFireStore().then(
                  (value) => ap
                      .saveUserDataSharePreference()
                      .then((value) => ap.setSignIn().then(
                            (value) => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyHomePage()),
                                (route) => false),
                          )),
                );
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserInformationScreen(),
                ),
                (route) => false);
          }
        });
      },
    );
  }
}
