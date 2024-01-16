import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // Get instance of firestore
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  // Get user stream
  /*
    <List<Map<String, dynamic>> = 
    [
        {
        'email': 'test@gmail.com',
        'id': // add an actual ID here
        },
        // (kind of a way to represent a map of users)
        {
        'email': 'test@gmail.com',
        'id': // add an actual ID here
        }
    ]
  */
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firebase.collection("Users").snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        // Go through each user 
        final user = doc.data();
        // You can further process 'user' here if needed
        return user;
      }).toList();
    });
  }

  // Send message

  // Get messages
}
