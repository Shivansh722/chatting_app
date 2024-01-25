import 'package:chat/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatService {
  // Get instance of firestore and auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    return _firestore.collection("Users").snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        // Go through each user 
        final user = doc.data();
        // You can further process 'user' here if needed
        return user;
      }).toList();
    });
  }

  // Send message
  Future<void> sendMessage(String receiverID, message) async
  {
    final currentUserID = _auth.currentUser!.uid;
    final currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    

    //write a new message to firestore(create message object)
    Message newMessage = Message(
    senderID: currentUserID,
    senderEmail: currentUserEmail,
    receiverID: receiverID,
    message: message,
    timestamp: timestamp,
    );
 
    // construct chat  room for two users(sorted to ensure uniqueness of the id)
    List<String> ids = [currentUserID, receiverID];
    ids.sort();//sorting the ids for any two people will always give the same chat room id
    String chatRoomId = ids.join('_');
    // print(chatRoomId);
    print(chatRoomId);
    //add new message to the database
    await _firestore.
    collection("Chat_rooms").
    doc(chatRoomId).
    collection("Messages").
    add(newMessage.toMap());
  }

    //get messeges
    Stream<QuerySnapshot> getMessages(String userID,otherUserID){
      //construct a chatroom ID for two users

      List<String> ids = [userID,otherUserID];
      ids.sort();//sorting the ids for any two people will always give the same chat room id
      String chatRoomId = ids.join('_');

      return _firestore
      .collection("Chat_rooms").
      doc(chatRoomId).
      collection("Messages").
      orderBy("timestamp",descending: false).
      snapshots();
    }
  
  }

