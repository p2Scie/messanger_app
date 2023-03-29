import 'package:messanger_app/controller/firebase_manager.dart';
import 'package:messanger_app/controller/globale.dart';
import 'package:messanger_app/view/chatroom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Variables
  List<bool> selection = [true, false];
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  //Methodes
  popError() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          if (defaultTargetPlatform == TargetPlatform.iOS) {
            return CupertinoAlertDialog(
              title: Text("Erreur"),
              content: Lottie.asset('error-animation.json'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
            );
          } else {
            return AlertDialog(
              title: Text("Erreur"),
              content: Lottie.asset('error-animation.json'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(padding: const EdgeInsets.all(10.0), child: bodyPage()));
  }

  Widget bodyPage() {
    return Column(
      children: [
        // Logo
        Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  image: AssetImage('assets/flutter_logo.png'),
                  fit: BoxFit.contain)),
        ),
        const SizedBox(height: 10),

        //toogleButton
        ToggleButtons(
            onPressed: (value) {
              setState(() {
                selection[0] = value == 0;
                selection[1] = value == 1;
              });
            },
            isSelected: selection,
            children: const [
              Text('Connexion'),
              Text('Inscription'),
            ]),
        const SizedBox(height: 10),
        //Adresse email
        TextField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.mail),
              hintText: "Entrer votre adresse mail",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
        const SizedBox(height: 10),
        // Mot de passe
        TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: "Entrer votre mot de passe",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              //connexion
              if (selection[0]) {
                FirebaseManager()
                    .login(email.text, password.text)
                    .then((value) {
                  setState(() {
                    myUser = value;
                  });

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Chatroom();
                  }));
                }).catchError((onError) {
                  // afficher un popup erreur de mot de passe
                  popError();
                });
              } else {
                //inscription

                FirebaseManager()
                    .register(email.text, password.text)
                    .then((value) {
                  setState(() {
                    myUser = value;
                  });

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Chatroom();
                  }));
                }).catchError((onError) {
                  // afficher un pop erreur de mot de passe
                  popError();
                });
              }
            },
            child: Text(selection[0] ? 'Connexion' : 'Inscription'))
      ],
    );
  }
}
