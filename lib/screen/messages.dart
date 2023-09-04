import 'package:bellehouse/screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  //instance of auth user
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        title: const Text("Messages"),
      ),
      body: _buildUserList(),
    );
  }

  //build a list of users except the current user

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error occured');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          ),
        );
      },
    );
  }

//build individual user list items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //diaplay all users except current user
    if (_firebaseAuth.currentUser?.uid != data['uid']) {
      return ListTile(
        title: Container(
          height: 50,
          color: Colors.grey.shade300,
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    foregroundImage: NetworkImage(data['profilePicture']),
                  ),
                  Text(data['name'])
                ],
              )
              //  Text(
              //   data['name'],
              //   style: const TextStyle(
              //       fontWeight: FontWeight.bold, letterSpacing: 1.3),
              // ),
              ),
        ),
        onTap: () {
          //pass the clicked user's UID to the chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                //  receiverUserEmail: data['email'],
                receiverUserID: data['uid'],
                receiverName: data['name'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
