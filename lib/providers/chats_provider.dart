import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/chat.dart';

class ChatProvider with ChangeNotifier {
  List<Chat> chats = List.empty(growable: true);

  Future<void> formulateChats(List data, String currentUserId) async {
    chats.clear();
    for (final doc in data) {
      final Chat chat = await Chat.fromJson(doc, currentUserId);
      chats.add(chat);
    }

    notifyListeners();
  }
}
