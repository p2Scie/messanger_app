import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messanger_app/controller/firebase_manager.dart';
import 'package:messanger_app/controller/globale.dart';

import '../model/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Variables
  TextEditingController msgContent = TextEditingController();

  // Méthodes

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: bodyPage()));
  }

  Widget bodyPage() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseManager().cloudMessages.orderBy("DATE", descending: true).snapshots(),
        builder: (context, snap) {
          List messages = snap.data?.docs ?? [];
          if (messages.isEmpty) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return Column(

              children: [
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: messages.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      //physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        ChatMessage _chatmessage = ChatMessage(messages[index]);
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (_chatmessage.receiverID == myUser.uid
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (_chatmessage.receiverID == myUser.uid
                                    ? Colors.grey.shade200
                                    : Colors.blue[200]),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                _chatmessage.content,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextField(
                              controller: msgContent,
                              decoration: const InputDecoration(
                                  hintText: "Rédigez un message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(width: 15),
                          FloatingActionButton(
                            onPressed: () {
                              FirebaseManager()
                                  .addMessage(
                                      myUser.uid, receiverID, msgContent.text)
                                  .catchError((onError) {
                                // Afficher un message d'erreur
                              });
                            },
                            backgroundColor: Colors.blue,
                            elevation: 0,
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        });
  }
}
