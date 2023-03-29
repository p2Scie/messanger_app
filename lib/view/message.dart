import 'package:flutter/material.dart';
import 'package:messanger_app/controller/messageController.dart';
import 'package:messanger_app/model/utilisateur.dart';

class SendMessageView extends StatefulWidget {
  final Utilisateur from;
  final Utilisateur to;

  const SendMessageView({required this.from, required this.to});

  @override
  _SendMessageViewState createState() => _SendMessageViewState();
}

class _SendMessageViewState extends State<SendMessageView> {
  final TextEditingController _controller = TextEditingController();
  final MessageController _messageController = MessageController(from: widget.from, to: widget.to);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envoyer un message'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Contenu du message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await _messageController._sendMessage(
                    widget.from, widget.to, _controller.text);
                Navigator.pop(context);
              },
              child: Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }
}
