import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/screens/chat_info.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  String name;
  String messageText;
  Image image;
  String time;
  bool isMessageRead;

  ChatWidget(
      {required this.name,
      required this.messageText,
      required this.image,
      required this.time,
      required this.isMessageRead});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChatDetailPage()
        ));

      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffE8E8F0),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffE8E8F0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      height: 53,
                      width: 53,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              ColorName.gradientOneGreen,
                              ColorName.gradientTwoGreen
                            ],
                          )),
                      child: image),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name),
                      Text(messageText),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(time),
                  Text(
                    '',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: isMessageRead
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
