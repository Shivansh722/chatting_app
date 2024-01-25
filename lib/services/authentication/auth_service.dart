// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign in
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Signing in the user
      print(email);
      print(password);

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e);
      throw Exception(e.code);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // Sign up
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      // Creating user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user info in a separate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e);
      throw Exception(e.code);
    }
  }
}
