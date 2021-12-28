import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/chat.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context, listen: false).currentUser;
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("chats")
              .where("members.${user.uid}", isEqualTo: true)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text("No internet Connection"));

              case ConnectionState.waiting:
                // TODO: Handle this case.
                return Center(child: CircularProgressIndicator());

              case ConnectionState.active:
                final data = snapshot.data.docs;
                //TODO: Solve your problem
                List chats =
                    data.map((e) => Chat.fromJson(e, user.uid)).toList();

                return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      return Text(chat.members.toString());
                    });
              case ConnectionState.done:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
