import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/chat.dart';
import 'package:shop_app/models/shoppie_user.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/providers/chats_provider.dart';

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
                log(data.first.runtimeType.toString());

                Provider.of<ChatProvider>(context, listen: false)
                    .formulateChats(data, user.uid);

                return Consumer<ChatProvider>(builder: (context, provider, _) {
                  return ListView.builder(
                      itemCount: provider.chats.length,
                      itemBuilder: (context, index) {
                        final chat = provider.chats[index];
                        return ListTile(
                          onTap: () {
                            log("OTHER USER ID: ${chat.user!.uid}");
                            log(" MY USER ID: ${user.uid}");
                            Provider.of<HomeNotifier>(context, listen: false)
                                .openChatBox(context,
                                    otherUserId: chat.user!.uid,
                                    isFromSeller: user.type == UserType.seller
                                        ? true
                                        : null);
                          },
                          title: Text(chat.user!.name),
                          leading: CircleAvatar(
                              radius: 35,
                              backgroundImage: chat.user!.image == null
                                  ? null
                                  : NetworkImage(chat.user!.image!),
                              child: chat.user!.image == null
                                  ? CircleAvatar(
                                      child: Center(
                                        child: Text(
                                          chat.user!.name[0],
                                        ),
                                      ),
                                    )
                                  : SizedBox()),
                        );
                      });
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
