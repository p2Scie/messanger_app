import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messanger_app/controller/globale.dart';
import 'package:messanger_app/view/auth_page.dart';
import '../controller/firebase_manager.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Variables
    String? urlImage;
    String? nameImage;
    Uint8List? dataImage;

  // Méthodes
  openImage() async{
    FilePickerResult? resultat = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true
    );
    if(resultat!=null){
      nameImage = resultat.files.last.name;
      dataImage = resultat.files.first.bytes;
      confirmationPop();
    }
  }

  confirmationPop(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title : Text(nameImage!),
            content: Image.memory(dataImage!),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: const Text("Annulation")
              ),
              TextButton(
                  onPressed: (){
                    //enregistrer dans la base de donnée
                    FirebaseManager().upload(myUser.uid, nameImage!, dataImage!).then((value){
                      setState(() {
                        urlImage = value;
                        myUser.avatar = urlImage;
                      });

                      Map<String,dynamic> map = {
                        "AVATAR" : urlImage
                      };
                      FirebaseManager().updateUser(myUser.uid, map);
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Confirmation")
              )
            ],

          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0), 
        child: bodyPage()
        ),
    );
  }

  Widget bodyPage() {
    return Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children : [
        InkWell(
          onTap: (){
            openImage();
          },
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(myUser.avatar??defaultImage),
          ),
        ),
        const SizedBox(height: 50),
        Text(myUser.pseudo??"Unknown"),
        const SizedBox(height: 30),
        Text(myUser.email),
        const SizedBox(height: 30),
        Text(lang??"Langue indisponible"),
        const SizedBox(height: 50),
        TextButton(
          onPressed: () {
            FirebaseManager().logout();
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=>const AuthPage()
              ));
          },
          child: const Text('Deconnexion')
        )

      ],
      )
    );
  }
}



