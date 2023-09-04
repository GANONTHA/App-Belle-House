import 'package:bellehouse/screen/welcome/welcome_screen.dart';
import 'package:bellehouse/services/auth/authProvider.dart';
import 'package:bellehouse/utilities/dialogs/logout_dialog.dart';
import 'package:bellehouse/utilities/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //sign user out
  void signOut() async {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    authService.userSignOut().then(
          (value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const WelcomePage()),
              (route) => false),
        );
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
            );
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
          color: const Color(0xFF6C63FF),
        ),
        title: const Text("Profile screen"),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
            color: Colors.black,
          ),
        ],
      ),
      body: Column(
        children: [
          //profile picture
          SizedBox(
            width: 90,
            height: 90,
            child: CircleAvatar(
              backgroundImage: NetworkImage(ap.userModel!.profilePicture),
            ),
          ),
          const SizedBox(height: 20),
          Text(ap.userModel!.name),
          Text("Telephone: ${ap.userModel!.phoneNumber}"),
          const SizedBox(height: 20),
          //   _buildUserInfos(),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                side: BorderSide.none,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'Editer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 10),

          //MENU

          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: const Icon(
                            LineAwesomeIcons.cog,
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Parametres',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: const Icon(
                        LineAwesomeIcons.angle_right,
                        color: Color(0xFF6C63FF),
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Deconnexion',
                        style: TextStyle(fontSize: 13),
                      ),
                      IconButton(
                        onPressed: () async {
                          final shouldLogOut = await showLougOutDialog(context);
                          if (shouldLogOut) {
                            try {
                              signOut();
                            } catch (e) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString(),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        //insert a LineAwesome Icon signout
                        icon: const Icon(
                          Icons.logout,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfos() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error occured');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Column(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

//build individual user list items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    return ListTile(
      title: Container(
        height: 40,
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            data['name'],
            style: const TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 1.3),
          ),
        ),
      ),
    );
  }
}
