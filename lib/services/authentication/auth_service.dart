// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      print(email);
      print(password);
      
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e);
      throw Exception(e.code);
    }
    catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  // Sign out

Future<void> signOut() async {
  
  return await _auth.signOut();
}
//sign up
Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password

      );

      return userCredential;

  } on FirebaseAuthException catch (e) {
    throw Exception(e.code);
    print(e);
  }


}

}


  // Errors
  
