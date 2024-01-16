import 'package:chat/services/authentication/auth_service.dart';
import 'package:chat/components/my_button.dart';
import 'package:chat/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

   RegisterPage({super.key,required this.onTap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confpasswordController = TextEditingController();

//tap to go to register
  final void Function()? onTap;
  //register function
  void register(BuildContext context) {
    final _auth = AuthService();
    //check if passwords match
    if(_passwordController.text == _confpasswordController.text)
    {
      try{
        _auth.signUpWithEmailAndPassword(_emailController.text, _passwordController.text);
      }
      catch(e){
        print(e);
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
      //show error
      }
    }
    else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords do not match"),
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              "Let's create an account!",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            
            const SizedBox(height: 25),

            // Email field
            MyTextField(
              hintText: "Email",
              controller : _emailController,
            ),
            
            const SizedBox(height: 12),

            // Password field
            MyTextField(
              hintText: "Password",
              controller : _passwordController,
            ),
            
            const SizedBox(height: 12),

            MyTextField(
              hintText: "Confirm Password",
              controller : _confpasswordController,
            ),
            // Login button
            const SizedBox(height: 12),
            
             MyButton(
              text: "Register",
              onTap: () => register(context), // Use lowercase login method
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
                    "Login now",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold
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