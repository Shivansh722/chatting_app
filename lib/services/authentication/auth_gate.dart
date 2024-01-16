import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_or_register.dart'; // Assuming LoginOrRegister is the appropriate import
 import 'package:chat/pages/home_page.dart';// Assuming HomePage is the appropriate import

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in 
          if (snapshot.hasData) {
            return  HomePage();
          }
          // User is logged out
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
