import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  //INITIALY SHOW LOGIN PAGE
  bool showLoginPage = true;

  void toggleView() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: toggleView,
      );
      
    } else {
      return RegisterPage(
        onTap: toggleView,
      );
    }
  }
}