import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messanger_app/model/utilisateur.dart';

class Message {
//Attributs
  late String uid;
  late String content;
  late Utilisateur from;
  late Utilisateur to;
  DateTime? timestamp;

//Constructeurs
  Message({
    required this.uid,
    required this.content,
    required this.from,
    required this.to,
    this.timestamp,
  });

// Constructeur nommé pour un message vide
  Message.empty()
      : uid = '',
        content = '',
        from = Utilisateur.empty(),
        to = Utilisateur.empty(),
        timestamp = null;

// Constructeur à partir d'un DocumentSnapshot
  Message.fromSnapshot(DocumentSnapshot snapshot) {
    uid = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    from = map["FROM"];
    to = map["TO"];
    content = map["CONTENT"];
    timestamp = map["TIMESTAMP"].toDate();
  }
}
