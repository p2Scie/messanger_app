import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messanger_app/model/message.dart';
import 'package:messanger_app/model/utilisateur.dart';

class MessageController extends StatefulWidget {
  final Utilisateur from;
  final Utilisateur to;

  MessageController({required this.from, required this.to});

  @override
  _SendMessageControllerState createState() => _SendMessageControllerState();
}

class _SendMessageControllerState extends State<MessageController> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      Message message = Message(
        uid: '',
        content: _messageController.text,
        from: widget.from,
        to: widget.to,
        timestamp: DateTime.now(),
      );
      FirebaseFirestore.instance.collection('messages').add({
        'FROM': message.from.toMap(),
        'TO': message.to.toMap(),
        'CONTENT': message.content,
        'TIMESTAMP': message.timestamp,
      });
      _messageController.clear();
    }
  }

  @override
  _SendMessageControllerState createState() => _SendMessageControllerState();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envoyer un message'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Entrez votre message',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _sendMessage,
            child: Text('Envoyer'),
          ),
        ],
      ),
    );
  }
}
