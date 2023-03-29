import 'package:flutter/material.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({Key? key}) : super(key: key);

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  // Variables
  int currentPage = 0;
  List<bool> selection = [true, false];

  // Méthodes


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(10.0), child: bodyPage()),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile",
          ),
        ],
        currentIndex: currentPage,
        onTap: (int index){
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }

  Widget bodyPage() {
    if(currentPage == 0){
      return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Chat"),
      ],
      );
    }else{
      return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Profile"),
      ],
      );
    }
  }
}



