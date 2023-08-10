import 'dart:io';

import 'package:chat_test/res/assets/assets.gen.dart';
import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Chat extends StatefulWidget {
  ChatUsers info;

  Chat({super.key, required this.info});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController controller = TextEditingController();
  bool isIconVisible = false;
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  ImagePicker picker = ImagePicker();
  XFile? file;

  @override
  void initState() {
    super.initState();
    //connect();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void sendMessage(String message, String path) {
    setMessage("source", message, path);
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
        path: path,
        type: type,
        message: message,
        time: DateTime.now(),
        answer: true);

    setState(() {
      widget.info.messageText.add(messageModel);
    });
  }

  void sendImage(String path, String message) {
    setState(() {
      print(path);
      print('ok');
      widget.info.messageText.add(MessageModel(
          path: path,
          message: 'image',
          type: 'source',
          time: DateTime.now(),
          answer: true));
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorName.color9,
        centerTitle: true,
        title: Text(
          widget.info.name,
          style: AppTypography.gilroySemiBold25.copyWith(
            color: ColorName.color1,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: widget.info.messageText.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.info.messageText.length) {
                      return Container(
                        height: 35,
                      );
                    }
                    if (widget.info.messageText[index].type == "source") {
                      if (widget.info.messageText[index].path != '') {
                        return OvnFileCard(
                            time: '${widget.info.messageText[index].time.hour} : ${widget.info.messageText[index].time.minute}',
                            path: widget.info.messageText[index].path);
                      } else {
                        return OwnMessageCard(
                          message: widget.info.messageText[index].message,
                          time: '${widget.info.messageText[index].time.hour} : ${widget.info.messageText[index].time.minute}',
                        );
                      }
                    } else {
                      return ReplyCard(
                        message: widget.info.messageText[index].message,
                        time: '${widget.info.messageText[index].time.hour} : ${widget.info.messageText[index].time.minute}',
                      );
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 16,
                  child: Center(
                    child: Card(
                      color: const Color(0xffEBEAE4),
                      margin:
                          const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        controller: _controller,
                        focusNode: focusNode,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              sendButton = true;
                            });
                          } else {
                            setState(() {
                              sendButton = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5),
                          border: InputBorder.none,
                          prefixIcon: GestureDetector(
                            onTap: () async {
                              file = await picker.pickImage(
                                  source: ImageSource.gallery);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => CameraViewPage(
                                    path: file!.path,
                                    onImageSend: sendImage,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(13),
                              child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Assets.icons.chat.svg()),
                            ),
                          ),
                          suffixIcon: _controller.text.isEmpty
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.info.messageText.add(
                                        MessageModel(
                                            path: '',
                                            message: _controller.text,
                                            type: "source",
                                            time: DateTime.now(),
                                            answer: true),
                                      );
                                      _controller.clear();
                                      _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeOut);
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    });
                                  },
                                  child: Icon(Icons.send),
                                ),
                          hintText: 'Введите сообщение',
                          hintStyle: AppTypography.gilroyMedium16.copyWith(
                            color: ColorName.color7.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          onWillPop: () {
            if (show) {
              setState(() {
                show = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        ),
      ),
    );
  }
}

class OvnFileCard extends StatelessWidget {
  const OvnFileCard({Key? key, required this.path, required this.time})
      : super(key: key);
  final String path;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xffEBEAE4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.file(
                    File(path),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Text(
                time,
                style: AppTypography.gilroyMedium16.copyWith(
                  color: ColorName.color7.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key, required this.message, required this.time});

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: ColorName.white,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 55,
                  top: 8,
                  bottom: 8,
                ),
                child: Text(message, style: AppTypography.gilroyMedium16),
              ),
              Positioned(
                bottom: 8,
                right: 10,
                child: Text(
                  time,
                  style: AppTypography.gilroyMedium16.copyWith(
                    color: ColorName.color7.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key, required this.message, required this.time});

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: const Color(0xffEBEAE4),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 55,
                  top: 8,
                  bottom: 8,
                ),
                child: Text(message, style: AppTypography.gilroyMedium16),
              ),
              Positioned(
                bottom: 8,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      time,
                      style: AppTypography.gilroyMedium16.copyWith(
                        color: ColorName.color7.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CameraViewPage extends StatefulWidget {
  const CameraViewPage(
      {Key? key, required this.path, required this.onImageSend})
      : super(key: key);
  final String path;
  final Function onImageSend;

  @override
  State<CameraViewPage> createState() => _CameraViewPageState();
}

class _CameraViewPageState extends State<CameraViewPage> {
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 150,
                child: Image.file(
                  File(widget.path),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.black38,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: TextFormField(
                    controller: message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    maxLines: 6,
                    minLines: 1,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add Caption....",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            widget.onImageSend(
                                widget.path, message.text.trim());
                          },
                          child: CircleAvatar(
                            radius: 27,
                            backgroundColor: Colors.tealAccent[700],
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 27,
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatUsers {
  String name;
  List<MessageModel> messageText;
  Image image;

  ChatUsers({
    required this.name,
    required this.messageText,
    required this.image,
  });
}

class MessageModel {
  String type;
  bool answer;
  String message;
  DateTime time;
  String path;

  MessageModel(
      {required this.path,
      required this.message,
      required this.type,
      required this.time,
      required this.answer});
}

List<ChatUsers> chatUser = [
  ChatUsers(
    name: 'Военный билет',
    messageText: [
      MessageModel(
        path: '',
        message: 'Здравствуйте, вы скоро там?',
        type: 'source',
        time: DateTime.now().copyWith(hour: 12, minute: 40),
        answer: true,
      ),
      MessageModel(
        path: '',
        message: 'Здравствуйте, уже иду',
        type: '',
        time: DateTime.now().copyWith(hour: 16, minute: 22),
        answer: true,
      )
    ],
    image: Assets.images.image1.image(),
  ),
  ChatUsers(
    name: 'Налоговые отчеты',
    messageText: [
      MessageModel(
        path: '',
        message: 'Здравствуйте, вы скоро там?',
        type: 'source',
        time: DateTime.now().copyWith(hour: 12, minute: 40),
        answer: true,
      ),
      MessageModel(
        path: '',
        message: 'Привет, тут сообщение бла бла бла ',
        type: '',
        time: DateTime.now().copyWith(hour: 16, minute: 22),
        answer: true,
      )
    ],
    image: Assets.images.image2.image(),
  ),
  ChatUsers(
    name: 'Военный билет',
    messageText: [
      MessageModel(
        path: '',
        message: 'Здравствуйте, вы скоро там?',
        type: 'source',
        time: DateTime.now().copyWith(hour: 12, minute: 40),
        answer: true,
      ),
      MessageModel(
        path: '',
        message: 'Здравствуйте, уже иду',
        type: '',
        time: DateTime.now().copyWith(hour: 16, minute: 22),
        answer: true,
      )
    ],
    image: Assets.images.image3.image(),
  ),
];
