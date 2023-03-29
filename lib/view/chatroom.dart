import 'package:messanger_app/controller/globale.dart';
import 'package:messanger_app/model/utilisateur.dart';
import 'package:flutter/material.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({Key? key}) : super(key: key);

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  // Variables
  int currentPage = 0;

  // Méthodes
  openImage() {

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  openImage();
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(myUser.avatar??defaultImage) ,
                ),
              ),

              const SizedBox(height: 60),

              Text(myUser.pseudo??''),
              const SizedBox(height: 10),
              Text(myUser.email),
              const SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    // Déconnexion
                  },
                  child: const Text("Déconnexion"))
            ],
          )),
      appBar: AppBar(),
      body: bodyPage(currentPage),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Listes'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoris'),
        ],
      ),
    );
  }

  Widget bodyPage(int page) {
    switch (page) {
      case 0:
        return const Text('First page');
      case 1:
        return const Text('Second page');
      default:
        return const Text('Mauvaise page');
    }
  }
}
