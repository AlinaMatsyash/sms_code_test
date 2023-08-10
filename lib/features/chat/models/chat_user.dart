import 'package:chat_test/res/assets/assets.gen.dart';
import 'package:flutter/material.dart';

class ChatUsersModel {
  String name;
  String messageText;
  Image image;
  String time;

  ChatUsersModel(
      {required this.name,
      required this.messageText,
      required this.image,
      required this.time});
}

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({
    required this.messageContent,
    required this.messageType,
  });
}
