import 'package:bellehouse/services/auth/authProvider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../components/my_Button.dart';

class RegisterPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controller

  final phoneController = TextEditingController();

  final confirmPasswordController = TextEditingController();

//handle error
  handleError(PlatformException error) {
    switch (error.code) {}
  }

  Country country = Country(
    phoneCode: '227',
    countryCode: "NE",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Niger",
    example: "Niger",
    displayName: "Niger",
    displayNameNoCountryCode: "NE",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xAB6C63FF),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Color(0xFF6C63FF),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'lib/assets/logo.png',
                          //color: Colors.blueAccent,
                        ),
                      )),
                ),
              ),

              //text
              const Center(
                child: Text(
                  'Entrer votre numero de telephone pour creer votre compte',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25.0),

              const SizedBox(
                height: 10.0,
              ),
              TextField(
                obscureText: false,
                cursorColor: const Color(0xFF6C63FF),
                controller: phoneController,
                autofocus: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  hintText: 'Entrer votre numero de telephone',
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: const CountryListThemeData(
                              bottomSheetHeight: 400),
                          onSelect: (value) {
                            setState(() {
                              country = value;
                            });
                          },
                        );
                      },
                      child: Text("${country.flagEmoji} +${country.phoneCode}"),
                    ),
                  ),
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              //button

              MyButton(
                onTap: sendPhoneNumber,
                text: 'CREER UN COMPTE',
              ),

              const SizedBox(
                height: 20,
              ),

              const Text(
                "Notre application vous offre une experience impeccable",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${country.phoneCode}$phoneNumber");
  }
}
