import 'package:cloud_firestore/cloud_firestore.dart';


class Message 
{
  //variables decleration
  final String senderID;
  
  final String message;
  final Timestamp timestamp;
  final String receiverID;
  final String senderEmail; 
 
  //
  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  // Convert a message object into a map? why?

Map<String, dynamic> toMap() {
  return {
    'senderID': senderID,
    'senderEmail': receiverID,
    'receiverID': receiverID,
    'message': message,
    'timestamp': timestamp,
  };
}
}