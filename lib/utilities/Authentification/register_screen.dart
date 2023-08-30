import 'package:bellehouse/components/my_text_field.dart';
import 'package:bellehouse/services/auth/authProvider.dart';
import 'package:bellehouse/services/auth/auth_service.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../components/my_Button.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  // ignore: prefer_const_constructors_in_immutables
  RegisterPage({
    super.key,
    this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controller
  final emaiController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordControler = TextEditingController();
  final nameController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  //method
  void singUp() async {
    if (passwordControler.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password don't match"),
        ),
      );
      return;
    }
    //get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailAndPassword(emaiController.text,
          passwordControler.text, nameController.text, phoneController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Image.asset(
                'lib/assets/logo.png',
                width: 300,
                height: 300,
                color: Colors.blueAccent,
              ),
              //text
              const Center(
                child: Text(
                  'Creer votre compte',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              const SizedBox(
                height: 10.0,
              ),
              //name text field
              MyTextField(
                hintText: 'Entrer votre Nom et Prenom',
                obscureText: false,
                controller: nameController,
                focus: true,
              ),
              const SizedBox(
                height: 10.0,
              ),

              //passowrd field
              MyTextField(
                hintText: 'Entrer un mot de passe',
                obscureText: true,
                controller: passwordControler,
                focus: false,
              ),
              const SizedBox(
                height: 10.0,
              ),
              //confirm password field
              MyTextField(
                hintText: 'confirmer le mot de passe',
                obscureText: true,
                controller: confirmPasswordController,
                focus: false,
              ),
              const SizedBox(
                height: 10.0,
              ),
              //email  field
              MyTextField(
                hintText: 'Entrer votre addresse email',
                obscureText: false,
                controller: emaiController,
                focus: false,
              ),
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

              MyButton(onTap: sendPhoneNumber, text: 'CREER UN COMPTE'),

              const SizedBox(
                height: 20,
              ),
              //old user? login

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Avez vous un compte?',
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Connecter a votre compte',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      )),
                ],
              ),
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
