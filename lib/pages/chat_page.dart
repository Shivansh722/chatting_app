import 'package:flutter/material.dart';
import 'package:chat/components/chat_bubble.dart';
import 'package:chat/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat/services/chat/chat_service.dart';
import 'package:chat/services/authentication/auth_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({Key? key, required this.receiverEmail, required this.receiverID})
      : super(key: key);

  // Text controller
  final TextEditingController _messageController = TextEditingController();
  // Chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Send message method
  void sendMessage() async {
    // If there is something inside the text field
    if (_messageController.text.isNotEmpty) {
      // Send message
      await _chatService.sendMessage(receiverID, _messageController.text);
      // Clear text field
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          receiverEmail,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Display all messages
          Expanded(child: _buildMessageList()),
          // Build user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        // Errors
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        // Return ListView.builder
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  // Build individual list tile for each message
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // Is current user
    bool isCurrentUser =
        data["senderID"] == _authService.getCurrentUser()!.uid;

    var align = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: align,
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser.toString())
        ],
      ),
    );
  }

  // Build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom:50.0),
      child: Row(
        children: [
          // Text field should take most of the space
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Let's talk!!",
              obscureText: false,
            ),
          ),

          // Send button
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(Icons.arrow_upward),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
