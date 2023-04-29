import 'package:campus_market/models/chat_model.dart';
import 'package:campus_market/repositories/chat_sessions_repo.dart';
import 'package:campus_market/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/chat_session.dart';
import '../models/product.dart';

class ChatPage extends StatefulWidget {
  final Product product;
  const ChatPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> messages = [];

  late UserRepo _userRepo;
  @override
  Widget build(BuildContext context) {
    _userRepo = context.read<UserRepo>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: FutureBuilder(
          future: ChatSessionsRepo().streamChat(widget.product, _userRepo.firestoreUserStream.value!.uid!),
          builder: (context, snap) {
            if (snap.data == null) {
              return const SizedBox.shrink();
            }
            return StreamBuilder<ChatSession>(
                stream: snap.data,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Expanded(
                          child: GroupedListView<ChatModel, DateTime>(
                        padding: const EdgeInsets.all(8),
                        reverse: true,
                        order: GroupedListOrder.DESC,
                        floatingHeader: true,
                        elements: messages,
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
                            alignment: message.userSentId == _userRepo.firestoreUserStream.value!.uid!
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Card(
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(message.text),
                              ),
                            )),
                      )),
                      Container(
                          color: Colors.grey,
                          child: TextField(
                            decoration: const InputDecoration(contentPadding: EdgeInsets.all(12), hintText: 'Type message here'),
                            onSubmitted: (text) {
                              final message = ChatModel(
                                text: text,
                                date: DateTime.now(),
                                productId: widget.product.id!,
                                userSentId: _userRepo.firestoreUserStream.value!.uid!,
                              );

                              setState(() => messages.add(message));
                            },
                          )),
                    ],
                  );
                });
          }),
    );
  }
}
