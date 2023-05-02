import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Chats"),
      ),
      body: Container(
        child: StreamBuilder(
          // stream: context.read<ChatSessionsRepo>().,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return SizedBox();
          },
        ),
      ),
    );
  }
}
