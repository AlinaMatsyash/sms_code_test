import 'package:chat_test/res/assets/assets.gen.dart';
import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/screens/chat_info.dart';
import 'package:chat_test/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  ChatUsers info;

  ChatWidget({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Chat(info: info)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF7F9FD),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffE8E8F0), width: 1),
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
                      child: info.image),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info.name,
                          style: AppTypography.gilroySemiBold17
                              .copyWith(color: ColorName.color1)),
                      const SizedBox(height: 3),
                      Container(
                        width: MediaQuery.of(context).size.width -190,
                        child: Text(info.messageText.last.message,
                            style: AppTypography.gilroyRegular15
                                .copyWith(color: ColorName.color3),overflow: TextOverflow.ellipsis, maxLines: 1,),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                      '${info.messageText.last.time.hour} : ${info.messageText.last.time.minute}'),
                  const SizedBox(height: 4),
                  Assets.icons.read.svg(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
