import 'package:bellehouse/components/my_Button.dart';
import 'package:bellehouse/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller
  final emaiController = TextEditingController();
  final passwordControler = TextEditingController();

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
              //logo
              Padding(
                padding: const EdgeInsets.only(top: 70.0, left: 40),
                child: Image.asset(
                  'lib/assets/logo.png',
                  width: 300,
                  height: 300,
                  color: Colors.blueAccent,
                ),
              ),
              //welcome back message

              //email textfield
              MyTextField(
                hintText: 'Addresse email',
                obscureText: false,
                controller: emaiController,
              ),

              const SizedBox(
                height: 20,
              ),
              //password textfield
              MyTextField(
                hintText: 'Creez votre mot de passe',
                obscureText: true,
                controller: passwordControler,
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
                    onTap: widget.onTap,
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
