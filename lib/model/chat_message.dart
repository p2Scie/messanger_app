import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  late String uid;
  late String senderID;
  late String receiverID;
  late String content;
  late DateTime date;

  //Constructeurs
  ChatMessage.empty() {
    uid = "";
    content = "";
    senderID = "";
    receiverID = "";
    date = DateTime.now();
  }

  ChatMessage(DocumentSnapshot snapshot) {
    uid = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    content = map["CONTENT"];
    receiverID = map["RECEIVER"];
    senderID = map["SENDER"];

    Timestamp timestamp = map["DATE"];
    date = timestamp.toDate();
  }
}

