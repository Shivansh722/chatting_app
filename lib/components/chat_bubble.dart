import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String isCurrentUser;

  const ChatBubble({Key? key, required this.message, required this.isCurrentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser == 'true' ? Colors.green : Colors.grey.shade500,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
