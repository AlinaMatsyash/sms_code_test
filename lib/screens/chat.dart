import 'package:chat_test/features/chat/models/chat_user.dart';
import 'package:chat_test/res/assets/assets.gen.dart';
import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/theme/app_typography.dart';
import 'package:chat_test/widgets/chat_widget.dart';
import 'package:chat_test/widgets/text_field.dart';
import 'package:flutter/material.dart';
List<ChatUsersModel> chatUsers = [
  ChatUsersModel(name: "Jane Russel", messageText: "Awesome Setup", image: Assets.images.image1.image(), time: "Now"),
  ChatUsersModel(name: "Glady's Murphy", messageText: "That's Great", image: Assets.images.image2.image(), time: "Yesterday"),
  ChatUsersModel(name: "Jorge Henry", messageText: "Hey where are you?", image: Assets.images.image3.image(), time: "31 Mar"),
  ChatUsersModel(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", image: Assets.images.image4.image(), time: "28 Mar"),
  ChatUsersModel(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", image: Assets.images.image5.image(), time: "23 Mar"),
];
List<ChatMessage> messages = [
  ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
];
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorName.white,
        centerTitle: true,
        title: Text(
          'Чат',
          style:
              AppTypography.gilroySemiBold25.copyWith(color: ColorName.color1),
        ),
        leadingWidth: 75,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorName.color9),
                child: const Icon(
                  Icons.arrow_back,
                  color: ColorName.color1,
                ),
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldSearchApp(controller: searchController),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF9FCEE),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xffE8E8F0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
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
                          child: const Icon(
                            Icons.sms,
                          )),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Служба поддержки'),
                        Text('Здравствуйте, обращайтесь'),

                      ],),
                      const Column(children: [
                        Text('12:14'),
                        Text(''),

                      ],)
                    ],
                  ),
                ),
              ),
              ListView.builder(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                //padding: EdgeInsets.only(top: 16),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ChatWidget(
                      name: chatUsers[index].name,
                      messageText: chatUsers[index].messageText,
                      image: chatUsers[index].image,
                      time: chatUsers[index].time,
                      isMessageRead: (index == 0 || index == 3)?true:false,
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
