import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:messanger_app/model/utilisateur.dart';

class FirebaseManager {
  // Attributs
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final couldMessages = FirebaseFirestore.instance.collection('MESSAGES');
  final cloudUsers = FirebaseFirestore.instance.collection('UTILISATEURS');

  // Créer un utilisateur
  Future<Utilisateur> register(String email, String password) async {
    UserCredential authResult = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    String? uid = authResult.user?.uid;
    if (uid == null) {
      return Future.error(("error"));
    }

    Map<String, dynamic> map = {"EMAIL": email};
    addUser(uid!, map);
    return getUser(uid!);
  }

  // Ajouter un utilisateur
  addUser(String uid, Map<String, dynamic> map) {
    cloudUsers.doc(uid).set(map);
  }

  //Récupérer un utilisateur
  Future<Utilisateur> getUser(String uid) async {
    DocumentSnapshot snapshot = await cloudUsers.doc(uid).get();
    return Utilisateur(snapshot);
  }

  //Connecter un utilisateur
  Future <Utilisateur> login(String email, String password) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

    String? uid = userCredential.user?.uid;

    if(uid == null) {
      return Future.error(('Problème de connexion'));
    }

    return getUser(uid!);
  }

  //Upload avatar
  Future<String> upload(String destination,String nameImage, Uint8List bytes) async {
    String url="";
    TaskSnapshot snapshot = await storage.ref("$destination/$nameImage").putData(bytes);
    url = await snapshot.ref.getDownloadURL();
    return url;

  }

  updateUser(String uid, Map<String,dynamic> map){
    cloudUsers.doc(uid).update(map);
}
}
