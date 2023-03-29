import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur {
  //attributs
  late String uid;
  String? pseudo;
  DateTime? birthday;
  String? nom;
  String? prenom;
  String? avatar;
  late String email;

  //constructor

  //
  Utilisateur.empty() {
    uid = "";
    email = "";
  }

  Utilisateur(DocumentSnapshot snapshot) {
    uid = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    pseudo = map["PSEUDO"];
    nom = map["NOM"];
    prenom = map["PRENOM"];
    avatar = map["AVATAR"];
    email = map["EMAIL"];

    Timestamp? timestamp = map['BIRTHDAY'];
    birthday = timestamp?.toDate();
  }
}