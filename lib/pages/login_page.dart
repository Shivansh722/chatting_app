import 'package:chat/services/authentication/auth_service.dart';
import 'package:chat/components/my_button.dart';
import 'package:chat/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key, required this.onTap}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Tap to go to register
  final void Function()? onTap;

  void login(BuildContext context) async {
    final authService = AuthService();

    // Try login
    try {
      await authService.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
    }
      // Show error
       catch (e) {
        print(e);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.chat,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 15),

            // Welcome back msg
            Text(
              "Great to have ya back!",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 25),

            // Email field
            MyTextField(
              hintText: "Email",
              controller: _emailController,
            ),

            const SizedBox(height: 12),

            // Password field
            MyTextField(
              hintText: "Password",
              controller: _passwordController,
            ),

            const SizedBox(height: 12),

            // Login button
            MyButton(
              text: "Login",
              
              onTap: () => login(context), // Use lowercase login method
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register now",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
