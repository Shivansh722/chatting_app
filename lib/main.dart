import 'package:chat/authentication/login_or_register.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: LoginOrRegister(),
      theme: lightMode,
    );
  }
}
