import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/theme/app_typography.dart';
import 'package:chat_test/widgets/text_field.dart';
import 'package:flutter/material.dart';

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

          ],
        ),
      ),
    );
  }
}
