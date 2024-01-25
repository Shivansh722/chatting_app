import 'package:flutter/material.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/components/my_drawer.dart';
import 'package:chat/components/user_tile.dart';
import 'package:chat/services/chat/chat_service.dart';
import 'package:chat/services/authentication/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  // Chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.background,
        
      appBar: AppBar(
        title: const Text(
          "Chat App",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: _buildUsersList(),
    );
  }

  // Build user list except the current user
  Widget _buildUsersList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong"),
          );
        }

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // Return ListView.builder
        return ListView(
          children: snapshot.data!.map<Widget>((userData) =>
              _buildUserListItem(userData, context)).toList(),
        );
      },
    );
  }

  // Build individual list tile for each user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if(userData['email'] != _authService.getCurrentUser()!.email){
      return UserTile(
      text: userData['email'],
      onTap: () {
        // Navigate to chat page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData['email'],
              receiverID: userData['uid'],
            ),
          ),
        );
      },
    );
    }
    else{
      return Container();
    }
  }
}
