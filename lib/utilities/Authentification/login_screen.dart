import 'package:bellehouse/components/my_Button.dart';
import 'package:bellehouse/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller
  final emaiController = TextEditingController();
  final passwordControler = TextEditingController();
  final nameController = TextEditingController();

  //method
  void logIn() async {
    //get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signIn(
        emaiController.text,
        passwordControler.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

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
              //welcome message
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Text(
                  'Bienvenu',
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //logo
              Padding(
                padding: const EdgeInsets.only(top: .0, left: 40),
                child: Image.asset(
                  'lib/assets/logo.png',
                  width: 300,
                  height: 300,
                  color: Colors.blueAccent,
                ),
              ),

              //email textfield
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  fillColor: Colors.grey[300],
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  hintText: 'Addresse email',
                ),
                obscureText: false,
                controller: emaiController,
              ),

              const SizedBox(
                height: 20,
              ),
              //password textfield
              MyTextField(
                hintText: 'Entrez votre mot de passe',
                obscureText: true,
                controller: passwordControler,
                focus: false,
              ),
              const SizedBox(
                height: 40,
              ),
              //sign in button
              MyButton(onTap: logIn, text: 'SE CONNECTER'),

              const SizedBox(
                height: 20,
              ),
              //not a member ? register now

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nouvel Utilisateur?',
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  GestureDetector(
                    child: const Text(
                      'Creer votre compte',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
