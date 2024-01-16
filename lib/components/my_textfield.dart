import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const MyTextField({super.key, required this.hintText, required this.controller});
  


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: hintText == "Password" ? true : false,
        controller: controller,//this was the whole point
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,

            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
           fillColor: Theme.of(context).colorScheme.tertiary,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        ),

       
      ),
    );
  }
}
