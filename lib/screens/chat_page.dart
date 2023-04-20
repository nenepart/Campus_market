import 'package:campus_market/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> message = [
    ChatModel(
      text: 'Yes sure',
      date: DateTime.now().subtract( const Duration(minutes: 1)),
      isSentByMe: false,
    ),
  ].reversed.toList();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: Column(
        children: [
          Expanded(
              child: GroupedListView<ChatModel, DateTime>(
                padding: const EdgeInsets.all(8),
                reverse: true,
                Order: GroupedListOrder.DESC,
                useStickyGroupSeparation: true,
                floatingHeader: true,
                elements: message,
                groupBy: (message) => DateTime(
                  message.date.year,
                  message.date.month,
                  message.date.day,
                ),
                groupHeaderBuilder: (ChatModel message) => SizedBox(
                  height: 40,
                    child: Center(
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              DateFormat.yMMMd().format(message.date),
                        style: const TextStyle(color: Colors.white),
                        ),
                        ),
                      ),
                    ),
                ),
                itemBuilder: (context, ChatModel message) => Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                ),
                child: Card(
                  elevation: 8,
                  child: Padding(padding: const EdgeInsets.all(12),
                    child: Text(message.text),
                  ),
                )
              ),
          ),
          Container(
            color: Colors.grey,
            child: const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: 'Type message here'
              ),
                onSubmitted: (text){
                  final message = ChatModel(
                    text: text,
                    date: DateTime.now(),
                    isSentByMe: true,
                  );

                  setState(() => message.add(message));
                },


          )
            ),
        ],
      ),
    );
  }
}

