import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/message.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/utils/utils.dart';

class Conversation extends StatelessWidget {
  Conversation({Key? key}) : super(key: key);

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatArgs;
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chats")
            .doc(args.chatId)
            .collection("messages")
            .orderBy("sentTime", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("No Internet Connection found");
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              // TODO: Handle this case.
              final data = snapshot.data.docs;

              final messages =
                  data.map((e) => Message.fromJson(e.data()!)).toList() as List;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index] as Message;
                        final isFromMe = message.senderId ==
                            Provider.of<AuthNotifier>(context, listen: false)
                                .currentUser
                                .uid;
                        return Row(
                          mainAxisAlignment: isFromMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (message.senderImageUrl != null)
                              CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(message.senderImageUrl!))
                            else
                              CircleAvatar(child: Text(message.senderName[0])),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(message.senderName),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: isFromMe
                                          ? Colors.orange
                                          : Colors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      message.body,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            textInputAction: TextInputAction.send,
                            onSubmitted: (val) {
                              Provider.of<HomeNotifier>(context, listen: false)
                                  .sendMessage(
                                context,
                                message: _messageController.text,
                                sellerId: args.sellerId,
                                chatId: args.chatId,
                              );
                              _messageController.clear();
                            },
                            controller: _messageController,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Provider.of<HomeNotifier>(context, listen: false)
                                .sendMessage(context,
                                    message: _messageController.text,
                                    sellerId: args.sellerId,
                                    chatId: args.chatId);
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.red,
                          ),
                          label: Text("Send"),
                        ),
                      ],
                    ),
                  )
                ],
              );
            case ConnectionState.done:
              return SizedBox();
          }
        },
      ),
    );
  }
}

class ChatArgs {
  String chatId;
  String sellerId;

  ChatArgs({required this.chatId, required this.sellerId});
}
