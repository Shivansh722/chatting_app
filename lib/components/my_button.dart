import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
 
  final void Function()? onTap;
  final String text;
  const MyButton({super.key, required this.text, required this.onTap});

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(
            text == "Login" ? "Login" : "Register",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
