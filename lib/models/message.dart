// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    required this.sentTime,
    this.senderImageUrl,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.body,
  });

  Timestamp sentTime;
  String? senderImageUrl;
  String senderId;
  String senderName;
  String receiverId;
  String body;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sentTime: json["sentTime"],
        senderImageUrl: json["senderImageUrl"],
        senderId: json["senderId"],
        senderName: json["senderName"],
        receiverId: json["receiverId"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "sentTime": sentTime,
        "senderImageUrl": senderImageUrl,
        "senderId": senderId,
        "senderName": senderName,
        "receiverId": receiverId,
        "body": body,
      };
}
