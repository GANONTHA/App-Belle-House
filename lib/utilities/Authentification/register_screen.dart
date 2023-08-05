import 'package:bellehouse/components/my_text_field.dart';
import 'package:bellehouse/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/my_Button.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controller
  final emaiController = TextEditingController();

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
      await authService.signUpWithEmailAndPassword(
          emaiController.text, passwordControler.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
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
              ),
              const SizedBox(
                height: 10.0,
              ),

              //passowrd field
              MyTextField(
                hintText: 'Entrer un mot de passe',
                obscureText: true,
                controller: passwordControler,
              ),
              const SizedBox(
                height: 10.0,
              ),
              //confirm password field
              MyTextField(
                hintText: 'confirmer le mot de passe',
                obscureText: true,
                controller: confirmPasswordController,
              ),
              const SizedBox(
                height: 10.0,
              ),
              //email or phone field
              MyTextField(
                hintText: 'Entrer votre numero de telephone ou email',
                obscureText: false,
                controller: emaiController,
              ),
              const SizedBox(
                height: 20.0,
              ),

              //button

              MyButton(onTap: singUp, text: 'CREER UN COMPTE'),

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
}
