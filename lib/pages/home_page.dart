
import "package:chat/components/my_drawer.dart";
import "package:chat/services/authentication/auth_service.dart";
import "package:chat/services/chat/chat_service.dart";
import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
   HomePage({super.key});

  //chat & auth service

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
        
      ),
     drawer: MyDrawer(),
     body: _builUsersList(),
      
    );
  }//build

  //build user list except current user

  Widget buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
     builder: (context, snapshot) {
      //error
        if(snapshot.hasError) {
          return Center(
            child: Text("Something went wrong"),
          );
        }
      //loding

      if(snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      //return listview.builder
      return ListView(
        children: snapshot.data!.map<Widget>((userData) => _buildUserListItem).toList(),
      );


     }
     );
  }

}