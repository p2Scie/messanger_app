import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur {
  //Attributs
  late String uid;
  late String email;
  String? pseudo;
  String? avatar;
  
  //Constructeurs
  Utilisateur.empty() {
    uid = "";
    email = "";
  }

  Utilisateur(DocumentSnapshot snapshot) {
    uid = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    pseudo = map["PSEUDO"];
    avatar = map["AVATAR"];
    email = map["EMAIL"];
  }

  toMap() {}
}