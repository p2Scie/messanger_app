import 'package:flutter/material.dart';
import 'package:messanger_app/view/chat_page.dart';
import 'package:messanger_app/view/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    switch(currentPage){
      case 0: return const ChatPage();
      case 1: return const Profile();
      default : return const Text("oops"); //Page 404
    }
  }
}



