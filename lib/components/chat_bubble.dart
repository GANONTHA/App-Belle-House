import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Color color;
  final String message;
  const ChatBubble({super.key, required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        color: color,
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );
  }
}
