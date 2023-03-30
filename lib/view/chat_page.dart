import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Variables
  List<String> conversations = ["Conversation 1","Conversation 2","Conversation 3"]; //Correspond aux discussion actives de l'user
  // Méthodes


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
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index){
        return Text(conversations[index]);
      },
    );
  }
}



