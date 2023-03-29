import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Variables

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
    return Column(
      children : const [
        Text("ChatPage page")
      ],
    );
  }
}



