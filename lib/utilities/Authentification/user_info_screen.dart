import 'dart:io';

import 'package:bellehouse/model/user_model.dart';
import 'package:bellehouse/services/auth/authProvider.dart';
import 'package:bellehouse/utilities/util_functions.dart';
import 'package:bellehouse/utilities/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
    super.dispose();
  }

//selecting an image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF6C63FF),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 25.0),
                  child: Center(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => selectImage(),
                          child: image == null
                              ? const CircleAvatar(
                                  backgroundColor: Color(0xFF6C63FF),
                                  radius: 50,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(image!),
                                  radius: 50,
                                ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15),
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              //name field
                              textField(
                                hintText: "Bruno",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxlines: 1,
                                controller: nameController,
                              ),

                              //email
                              textField(
                                hintText: "gbanontha@gmail.com",
                                icon: Icons.email,
                                inputType: TextInputType.emailAddress,
                                maxlines: 1,
                                controller: emailController,
                              ),
                              //bio
                              textField(
                                hintText: "Entrer votre biographie...",
                                icon: Icons.edit,
                                inputType: TextInputType.name,
                                maxlines: 2,
                                controller: bioController,
                              ),
                              const SizedBox(height: 20.0),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFF6C63FF),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: TextButton(
                                  onPressed: () {
                                    storeData();
                                  },
                                  child: const Text(
                                    'Continuer',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                        fontSize: 20.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget textField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxlines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        cursorColor: const Color(0xFF6C63FF),
        controller: controller,
        keyboardType: inputType,
        maxLines: maxlines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              color: Color(0xFF6C63FF),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Color(0xFF6C63FF),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          fillColor: const Color.fromARGB(255, 216, 215, 230),
          filled: true,
        ),
      ),
    );
  }

  //store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      email: emailController.text.trim(),
      name: nameController.text.trim(),
      bio: bioController.text.trim(),
      profilePicture: "",
      createAt: "",
      phoneNumber: "",
      uid: "",
    );
    if (image != null) {
      ap.createUser(
        context: context,
        onSuccess: () {
          //once the data is saved we need to store locally
          ap.saveUserDataSharePreference().then((value) {
            ap.setSignIn().then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
                (route) => false));
          });
        },
        profilePicture: image!,
        userModel: userModel,
      );
    } else {
      showSnackBar(context, "Ajoutez une photo de profile");
    }
  }
}
