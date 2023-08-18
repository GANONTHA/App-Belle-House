import 'package:bellehouse/components/chat_bubble.dart';
import 'package:bellehouse/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  final String receiverName;
  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID,
      required this.receiverName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Method to send the message

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      //make sure there's a message to send
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text, widget.receiverName);
      //clear the message after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        title: Text(widget.receiverName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //messages
            Expanded(
              child: _buildMessageList(),
            ),

            //user input
            _buildMessageInput(),
            const SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }

//build  message list
  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(
          _firebaseAuth.currentUser!.uid, widget.receiverUserID),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error.toString()}');
        }
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return const Text('Loading');
        }
        if (snapshot.hasData) {
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView(
              scrollDirection: Axis.vertical,
              reverse: true,
              //addAutomaticKeepAlives: true,
              children: documents
                  .map((document) => _buildMessageItem(document))
                  .toList());
        }
        return Container(
          color: Colors.amber,
        );
      },
    );
  }

//build a message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align the messages to the right if the sender is the current user, otherwise to the left
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      // height: 100,
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 5.0),
            ChatBubble(
              message: data['message'],
              color: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? const Color(0xFF6C63FF)
                  : Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }

//buiild a message Input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          //text field
          Expanded(
            child: TextField(
              controller: _messageController,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                fillColor: Colors.grey[300],
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[500]),
                hintText: 'Ecrivez votre message',
              ),
              obscureText: false,
            ),
          ),

          //send button
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 40,
              color: Color(0xFF6C63FF),
            ),
          )
        ],
      ),
    );
  }
}
